module SimpleSpark
  module Endpoints
    # Provides access to the /relay-webhooks endpoint
    # See: https://developers.sparkpost.com/api/#/reference/relay-webhooks
    class RelayWebhooks
      attr_accessor :client

      def initialize(client)
        @client = client
      end

      # Lists your relay webhooks
      # @return [Array] a list of Relay Webhook hash objects
      # @note See: https://developers.sparkpost.com/api/#/reference/relay-webhooks/create-and-list/list-all-relay-webhooks
      def list
        @client.call(:get, 'relay-webhooks')
      end

      # Create a relay webhook
      # @param values [Hash] the values to create with
      # @note See: https://developers.sparkpost.com/api/#/reference/relay-webhooks/create-and-list/create-a-relay-webhook
      # @note Example:
      # properties = {
      #   name: "Replies Webhook",
      #   target: "https://webhooks.customer.example/replies",
      #   auth_token: "",
      #   match: {
      #     protocol: "SMTP",
      #     domain: "email.example.com"
      #   }
      # }
      def create(values)
        @client.call(:post, 'relay-webhooks', values)
      end

      # Retrieve a relay webhook
      # @param webhook_id [String] the id to retrieve
      # @return [Hash] an Relay Webhook hash object
      # @note See: https://developers.sparkpost.com/api/#/reference/relay-webhooks/retrieve-update-and-delete/retrieve-a-relay-webhook
      def retrieve(webhook_id)
        @client.call(:get, "relay-webhooks/#{webhook_id}")
      end

      # Update a relay webhook
      # @param webhook_id [String] the id to retrieve
      # @param values [Hash] the values to update the relay webhook with
      # @return [Hash] an Relay Webhook hash object
      # @note Example:
      # properties = {
      #   name: "New Replies Webhook",
      #   target: "https://webhook.customer.example/replies"
      # }
      # @note See: https://developers.sparkpost.com/api/#/reference/relay-webhooks/create-and-list/update-a-relay-webhook
      def update(webhook_id, values)
        @client.call(:put, "relay-webhooks/#{webhook_id}", values)
      end

      # Delete a relay webhook
      # @param webhook_id [String] the id to retrieve
      # @note See: https://developers.sparkpost.com/api/#/reference/relay-webhooks/retrieve-update-and-delete/delete-a-relay-webhook
      def delete(webhook_id)
        @client.call(:delete, "relay-webhooks/#{webhook_id}")
      end
    end
  end
end
