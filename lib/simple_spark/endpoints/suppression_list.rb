module SimpleSpark
  module Endpoints
    # Provides access to the /suppression-list endpoint
    # @note Example suppression list recipient
    #   { "recipient": "rcpt_1@example.com", "transactional": true,
    #   "description": "User requested to not receive any transactional emails." }
    # @note See: https://developers.sparkpost.com/api/suppression-list
    class SuppressionList
      attr_accessor :client

      def initialize(client)
        @client = client
      end

      # Search for list entries
      # @param params [String] Params to use in the search
      # @return [Array] a list of sample Suppression Status hash objects
      # @note See: https://developers.sparkpost.com/api/suppression-list#suppression-list-search-get
      def search(params = {})
        @client.call(method: :get, path: 'suppression-list', query_params: params)
      end

      # Insert or Update List Entries
      # @param recipients [Array] the entries to insert or update
      # @note See: https://developers.sparkpost.com/api/suppression-list#suppression-list-bulk-insert-update-put
      def create_or_update(recipients)
        @client.call(method: :put, path: 'suppression-list', body_values: {recipients: recipients})
      end

      # Retrieve a Recipient Suppression Status
      # @param recipient_email [String] the recipient email to retrieve
      # @return [Hash] a suppression status result hash object
      # @note See: https://developers.sparkpost.com/api/suppression-list#suppression-list-retrieve,-delete-get
      def retrieve(recipient_email)
        recipient_email = @client.url_encode(recipient_email)
        @client.call(method: :get, path: "suppression-list/#{recipient_email}")
      end

      # Delete a List Entry
      # @param recipient_email [String] the recipient email to delete
      # @note See: https://developers.sparkpost.com/api/suppression-list#suppression-list-retrieve,-delete-delete
      def delete(recipient_email)
        recipient_email = @client.url_encode(recipient_email)
        @client.call(method: :delete, path: "suppression-list/#{recipient_email}")
      end
    end
  end
end
