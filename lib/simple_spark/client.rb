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

    def call(method, path, data = {})
      fail Exceptions::InvalidConfiguration.new({ method: method }), 'Only GET, POST and DELETE are supported' unless [:get, :post, :delete].include?(method)
      params = {
        path: "#{@base_path}#{path}",
        headers: default_headers,
        body: data.to_json
      }
      response = @session.send(method.to_s, params)

      # TODO deal with status here, 422, 404, and throttled

      # Need to deal with 204 for some calls too, success, no content in response

      process_response(response)
    end

    def process_response(response)
      response = JSON.parse(response.body)
      if response['errors']
        fail Exceptions::DeliveryException, response['errors']
      else
        response['results']
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
