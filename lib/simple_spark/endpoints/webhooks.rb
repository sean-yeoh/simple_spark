module SimpleSpark
  module Endpoints
    # Provides access to the /webhooks endpoint
    # @note Example webhook
    # @note See: https://developers.sparkpost.com/api/#/reference/webhooks
    class Webhooks
      attr_accessor :client

      def initialize(client)
        @client = client
      end

      # List currently extant webhooks
      # @return [Array] a list of Webhook hash objects
      # @note See: https://developers.sparkpost.com/api/#/reference/webhooks/list
      def list(timezone = nil)
        query_params = timezone.nil? ? {} : { timezone: timezone }
        @client.call(:get, 'webhooks', {}, query_params)
      end

      # Create a webhook
      # @param values [Hash] the values to create the webhook with
      # @note See: https://developers.sparkpost.com/api/#/reference/webhooks/create
      def create(values)
        @client.call(:post, 'webhooks', values)
      end

      # Retrieve details about a webhook by specifying its id
      # @param id [String] the ID of the webhook
      # @return [Hash] an Webhook hash object
      # @note See: https://developers.sparkpost.com/api/#/reference/webhooks/retrieve
      def retrieve(id)
        @client.call(:get, "webhooks/#{id}")
      end

      # Update a Webhook by its ID
      # @param id [String] the ID of the webhook
      # @param values [Hash] the values to update the webhook with
      # @note See: https://developers.sparkpost.com/api/#/reference/webhooks/update-and-delete
      def update(id, values)
        @client.call(:put, "webhooks/#{id}", values)
      end

      # Validates a Webhook by sending an example message event batch from the Webhooks API to the target URL
      # @param id [String] the ID of the webhook
      # @note See: https://developers.sparkpost.com/api/#/reference/webhooks/validate
      def validate(id)
        @client.call(:post, "webhooks/#{id}/validate")
      end

      # Batch status information
      # @param id [String] the ID of the webhook
      # @return [Array] a list of status hash objects
      # @note See: https://developers.sparkpost.com/api/#/reference/webhooks/batch-status
      def batch_status(id, limit = nil)
        query_params = limit.nil? ? {} : { limit: limit }
        @client.call(:get, "webhooks/#{id}/batch-status", {}, query_params)
      end

      # Returns sample event data
      # @param events [String] Event types for which to get a sample payload
      # @return [Array] a list of sample event hash objects
      # @note See: https://developers.sparkpost.com/api/#/reference/webhooks/events-samples
      def samples(events = nil)
        query_params = events.nil? ? {} : { events: events }
        @client.call(:get, 'webhooks/events/samples', {}, query_params)
      end

      # Delete a webhook
      # @param id [String] the ID
      # @note See: https://developers.sparkpost.com/api/#/reference/webhooks/update-and-delete
      def delete(id)
        @client.call(:delete, "webhooks/#{id}")
      end
    end
  end
end
