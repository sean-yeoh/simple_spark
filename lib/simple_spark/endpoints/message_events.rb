module SimpleSpark
  module Endpoints
    # Provides access to the /message-events endpoint
    # @note See: https://developers.sparkpost.com/api/#/reference/message-events
    class MessageEvents
      attr_accessor :client

      def initialize(client)
        @client = client
      end

      # Returns sample message_events
      # @param events [String] Event types for which to get a sample payload, use the Webhooks Events endpoint to list the
      #   available event types, defaults to all event types
      # @return [Array] a list of sample MessageEvent hash objects
      # @note See: https://developers.sparkpost.com/api/#/reference/message-events/events-samples
      def samples(events = nil)
        query_params = events.nil? ? {} : { events: events }
        @client.call(:get, 'message-events/events/samples', {}, query_params)
      end

      # Perform a filtered search for message event data. The response is sorted by descending timestamp.
      # @param params [String] Params to use in the search
      # @return [Array] a list of MessageEvent hash objects
      # @note See: https://developers.sparkpost.com/api/#/reference/message-events/search-for-message-events
      def search(params = {})
        @client.call(:get, 'message-events', {}, params)
      end
    end
  end
end
