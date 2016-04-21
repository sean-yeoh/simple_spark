module SimpleSpark
  module Endpoints
    # Provides access to the /metrics endpoint
    # @note See: https://developers.sparkpost.com/api/#/reference/metrics
    class Metrics
      attr_accessor :client

      def initialize(client)
        @client = client
      end

      # The Metrics API is designed for discoverability of child links. Calling the API root displays a list of URIs that exists within the Metrics API.
      # @return [Hash] containg a Metrics hash
      # @note See: https://developers.sparkpost.com/api/#/reference/metrics/metrics-discoverability-links
      def discoverability_links
        @client.call(method: :get, path: 'metrics', extract_results: false)
      end
    end
  end
end
