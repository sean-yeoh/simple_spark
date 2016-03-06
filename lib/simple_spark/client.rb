require 'rubygems'
require 'excon'
require 'json'

module SimpleSpark
  class Client
    def initialize(api_key = nil, api_host = 'https://api.sparkpost.com', base_path = '/api/v1/', debug = false)
      @api_key = api_key || ENV['SPARKPOST_API_KEY']
      @api_host = api_host || 'https://api.sparkpost.com'
      @base_path = base_path || '/api/v1/'

      fail Exceptions::InvalidConfiguration.new, 'You must provide a SparkPost API key' unless @api_key
      fail Exceptions::InvalidConfiguration.new, 'You must provide a SparkPost API host' unless @api_host # this should never occur unless the default above is changed
      fail Exceptions::InvalidConfiguration.new, 'You must provide a SparkPost base path' unless @base_path # this should never occur unless the default above is changed

      @debug = debug
      @session = Excon.new(@api_host, debug: @debug)
    end

    def call(method, path, body_values = {}, query_params = {})
      fail Exceptions::InvalidConfiguration.new({ method: method }), 'Only GET, POST, PUT and DELETE are supported' unless [:get, :post, :put, :delete].include?(method)

      path = "#{@base_path}#{path}"
      # path += '?' + URI.encode_www_form(query_params) if query_params.any?
      params = { path: path, headers: default_headers }
      params[:body] = body_values.to_json unless body_values.empty?
      params[:query] = query_params unless query_params.empty?
      response = @session.send(method.to_s, params)

      process_response(response)
    end

    def process_response(response)
      return true if response.status == 204

      response_body = JSON.parse(response.body)
      if response_body['errors']
        Exceptions::Error.fail_with_exception_for_status(response.status, response_body['errors'])
      else
        response_body['results'] ? response_body['results'] : true
      end
    end

    # Copied from http://apidock.com/ruby/ERB/Util/url_encode
    def url_encode(s)
      s.to_s.dup.force_encoding("ASCII-8BIT").gsub(/[^a-zA-Z0-9_\-.]/) { sprintf("%%%02X", $&.unpack("C")[0]) }
    end

    def default_headers
      {
        'User-Agent' => 'simple_spark/' + VERSION,
        'Content-Type' => 'application/json',
        'Authorization' => @api_key
      }
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
  end
end
