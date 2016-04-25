require 'rubygems'
require 'excon'
require 'json'

module SimpleSpark
  class Client
    def initialize(opts = {})
      @api_key = opts[:api_key] || ENV['SPARKPOST_API_KEY']
      @api_host = opts[:api_host] || 'https://api.sparkpost.com'
      @base_path = opts[:base_path] || '/api/v1/'
      @subaccount_id = opts[:subaccount_id]
      @headers = opts[:headers]

      fail Exceptions::InvalidConfiguration.new, 'You must provide a SparkPost API key' unless @api_key
      fail Exceptions::InvalidConfiguration.new, 'You must provide a SparkPost API host' unless @api_host # this should never occur unless the default above is changed
      fail Exceptions::InvalidConfiguration.new, 'You must provide a SparkPost base path' unless @base_path # this should never occur unless the default above is changed
      fail Exceptions::InvalidConfiguration.new, 'The headers options provided must be a valid Hash' if @headers && !@headers.is_a?(Hash)

      rails_development = true & defined?(Rails) && Rails.env.development?

      @debug = opts[:debug].nil? ? rails_development : opts[:debug]

      @session = Excon.new(@api_host, debug: @debug)
    end

    def call(opts)
      method = opts[:method]
      path = opts[:path]
      body_values = opts[:body_values] || {}
      query_params = opts[:query_values] || {}
      extract_results = opts[:extract_results].nil? ? true : opts[:extract_results]

      fail Exceptions::InvalidConfiguration.new(method: method), 'Only GET, POST, PUT and DELETE are supported' unless [:get, :post, :put, :delete].include?(method)

      path = "#{@base_path}#{path}"
      params = { path: path, headers: headers }
      params[:body] = body_values.to_json unless body_values.empty?
      params[:query] = query_params unless query_params.empty?
      response = @session.send(method.to_s, params)

      process_response(response, extract_results)

    rescue Excon::Errors::Timeout
      raise Exceptions::GatewayTimeoutExceeded
    end

    def process_response(response, extract_results)
      return true if response.status == 204

      response_body = JSON.parse(response.body)
      if response_body['errors']
        Exceptions::Error.fail_with_exception_for_status(response.status, response_body['errors'])
      else
        if extract_results
          response_body['results'] ? response_body['results'] : true
        else
          response_body
        end
      end
    end

    # Copied from http://apidock.com/ruby/ERB/Util/url_encode
    def url_encode(s)
      s.to_s.dup.force_encoding('ASCII-8BIT').gsub(/[^a-zA-Z0-9_\-.]/) { sprintf('%%%02X', $&.unpack('C')[0]) }
    end

    def headers
      defaults = {
        'User-Agent' => 'simple_spark/' + VERSION,
        'Content-Type' => 'application/json',
        'Accept' => 'application/json',
        'Authorization' => @api_key
      }
      defaults.merge!('X-MSYS-SUBACCOUNT' => @subaccount_id) if @subaccount_id
      defaults.merge!(@headers) if @headers
      defaults
    end

    def metrics
      Endpoints::Metrics.new(self)
    end

    def subaccounts
      Endpoints::Subaccounts.new(self)
    end

    def inbound_domains
      Endpoints::InboundDomains.new(self)
    end

    def sending_domains
      Endpoints::SendingDomains.new(self)
    end

    def templates
      Endpoints::Templates.new(self)
    end

    def transmissions
      Endpoints::Transmissions.new(self)
    end

    def message_events
      Endpoints::MessageEvents.new(self)
    end

    def webhooks
      Endpoints::Webhooks.new(self)
    end

    def relay_webhooks
      Endpoints::RelayWebhooks.new(self)
    end
  end
end
