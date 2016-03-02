require 'spark_post/snap/version'

require 'rubygems'
require 'excon'
require 'json'

module SparkPost
  class SnapClient
    def initialize(apikey, api_host = 'https://api.sparkpost.com', debug = false)
      fail Error, 'You must provide a SparkPost API key' unless @api_key
      @api_key = api_key || ENV['SPARKPOST_API_KEY']
      @api_host = api_host
      @path = '/api/v1/'

      @session = Excon.new @api_host
      @debug = debug
    end

    def get(url, params = {})
      call(:get, url, params)
    end

    def call(method, url, data = {})
      params = {
        path: "#{@path}#{url}.json",
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
        'User-Agent' => 'sparkpost-snap/' + VERSION,
        'Content-Type' => 'application/json',
        'Authorization' => @api_key
      }
    end
  end
end
