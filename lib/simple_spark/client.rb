require 'rubygems'
require 'excon'
require 'json'

module SimpleSpark
  class Client
    def initialize(api_key = nil, api_host = nil, base_path = '/api/v1/', debug = false)
      @api_key = api_key || ENV['SPARKPOST_API_KEY']
      @api_host = api_host || ENV['SPARKPOST_API_HOST'] || 'https://api.sparkpost.com'
      @base_path = base_path || '/api/v1/'

      fail Exceptions::InvalidConfiguration.new, 'You must provide a SparkPost API key' unless @api_key
      fail Exceptions::InvalidConfiguration.new, 'You must provide a SparkPost API host' unless @api_host # this should never occur unless the default above is changed
      fail Exceptions::InvalidConfiguration.new, 'You must provide a SparkPost base path' unless @base_path # this should never occur unless the default above is changed

      @debug = debug
      @session = Excon.new(@api_host, debug: @debug)
    end

    def call(method, path, values = {})
      fail Exceptions::InvalidConfiguration.new({ method: method }), 'Only GET, POST, PUT and DELETE are supported' unless [:get, :post, :put, :delete].include?(method)

      params = { path: "#{@base_path}#{path}", headers: default_headers }
      params[:body] = values.to_json unless values.empty?
      response = @session.send(method.to_s, params)

      process_response(response)
    end

    def process_response(response)
      return true if response.status == 204

      response_body = JSON.parse(response.body)
      if response_body['errors']
        Exceptions::Error.fail_with_exception_for_status(response.status, response_body['errors'])
      else
        response_body['results']
      end
    end

    def default_headers
      {
        'User-Agent' => 'simple_spark/' + VERSION,
        'Content-Type' => 'application/json',
        'Authorization' => @api_key
      }
    end

    def templates
      Templates.new(self)
    end

    def transmissions
      Transmissions.new(self)
    end
  end
end
