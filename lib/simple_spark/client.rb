require 'rubygems'
require 'excon'
require 'json'

module SimpleSpark
  class Client
    def initialize(api_key = nil, api_host = nil, base_path = '/api/v1/', debug = false)
      @api_key = api_key || ENV['SPARKPOST_API_KEY']
      @api_host = api_host || ENV['SPARKPOST_API_HOST'] || 'https://api.sparkpost.com'
      @base_path = base_path || '/api/v1/'

      fail Exceptions::InvalidConfiguration, 'You must provide a SparkPost API key' unless @api_key
      fail Exceptions::InvalidConfiguration, 'You must provide a SparkPost API host' unless @api_host

      @session = Excon.new @api_host
      @debug = debug
    end

    def call(method, path, data = {})
      fail InvalidConfiguration, 'Only GET, POST and DELETE are supported' unless [:get, :post, :delete].include?(method)
      params = {
        path: "#{@base_path}#{path}.json",
        headers: default_headers,
        body: data.to_json
      }
      response = @session.send(method.to_s, params)
      process_response(response)
    end

    def process_response(response)
      response = JSON.parse(response.body)
      if response['errors']
        fail SparkPost::DeliveryException, response['errors']
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
