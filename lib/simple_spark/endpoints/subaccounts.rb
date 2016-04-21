module SimpleSpark
  module Endpoints
    # Provides access to the /subaccounts endpoint
    # @note Example subaccount
    # @note See: https://developers.sparkpost.com/api/#/reference/subaccounts
    class Subaccounts
      attr_accessor :client

      def initialize(client)
        @client = client
      end

      # List subaccounts
      # @return [Array] a list of Subaccount hash objects
      # @note See: https://developers.sparkpost.com/api/#/reference/subaccounts/subaccounts-collection/list-subaccounts
      def list
        @client.call(method: :get, path: 'subaccounts')
      end

      # Create a subaccount
      # @param values [Hash] the values to create the subaccount with
      # @note Example:
      #   values = {
      #     "name": "Sparkle Ponies",
      #     "key_label": "API Key for Sparkle Ponies Subaccount",
      #     "key_grants": ["smtp/inject", "sending_domains/manage", "message_events/view", "suppression_lists/manage"]
      #   }
      # @note See: https://developers.sparkpost.com/api/#/reference/subaccounts/subaccounts-collection/create-new-subaccount
      def create(values)
        @client.call(method: :post, path: 'subaccounts', body_values: values)
      end

      # Retrieve details about a subaccount by specifying its id
      # @param id [Integer] the ID of the subaccount
      # @return [Hash] an Subaccount hash object
      # @note See: https://developers.sparkpost.com/api/#/reference/subaccounts/subaccounts-entity/list-specific-subaccount
      def retrieve(id)
        @client.call(method: :get, path: "subaccounts/#{id}")
      end

      # Update a Subaccount by its ID
      # @param id [Integer] the ID of the subaccount
      # @param values [Hash] the values to update the subaccount with
      # @note See: https://developers.sparkpost.com/api/#/reference/subaccounts/subaccounts-entity/edit-a-subaccount
      def update(id, values)
        @client.call(method: :put, path: "subaccounts/#{id}", body_values: values)
      end
    end
  end
end
