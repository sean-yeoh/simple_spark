module SimpleSpark
  module Endpoints
    # Provides access to the /recipient-lists endpoint
    # @note See: https://developers.sparkpost.com/api/recipient-lists
    class RecipientLists
      attr_accessor :client

      def initialize(client)
        @client = client
      end

      # List all recipient lists
      # @return [Array] an array of abbreviated recipient list objects
      # @note See: https://developers.sparkpost.com/api/recipient-lists/#recipient-lists-get-list-all-recipient-lists
      def list
        @client.call(method: :get, path: 'recipient-lists')
      end

      # Create a recipient list
      # @param values [Hash] the values to create the recipient list with, valid keys: [:id, :name, :description, :attributes, :recipients]
      # @param num_rcpt_errors [Integer] max number of recipient errors that this call can return
      # @return [Hash] details about created list
      # @note See: https://developers.sparkpost.com/api/recipient-lists#recipient-lists-post-create-a-recipient-list
      def create(values, num_rcpt_errors = nil)
        query_params = num_rcpt_errors.nil? ? '' : "?num_rcpt_errors=#{num_rcpt_errors.to_i}"
        @client.call(method: :post, path: "recipient-lists#{query_params}", body_values: values)
      end

      # Retrieve recipient list details
      # @param id [Integer] the recipient list ID to retrieve
      # @param show_recipients [Boolean] if true, return all the recipients contained in the list
      # @return [Hash] details about a specified recipient list
      # @note See: https://developers.sparkpost.com/api/recipient-lists/#recipient-lists-get-retrieve-a-recipient-list
      def retrieve(id, show_recipients = false)
        params = { show_recipients: show_recipients }.compact
        @client.call(method: :get, path: "recipient-lists/#{id}", query_values: params)
      end

      # Update a recipient list
      # @param id [Integer] the recipient list ID to update
      # @param values [Hash] hash of values to update, valid keys: [:name, :description, :attributes, :recipients]
      # @return [Hash] details on update operation
      # @note See: https://developers.sparkpost.com/api/recipient-lists/#recipient-lists-put-update-a-recipient-list
      def update(id, values)
        @client.call(method: :put, path: "recipient-lists/#{id}", body_values: values)
      end

      # Delete a recipient list
      # @param id [String] the ID
      # @note See: https://developers.sparkpost.com/api/recipient-lists#recipient-lists-delete-delete-a-recipient-list
      def delete(id)
        @client.call(method: :delete, path: "recipient-lists/#{id}")
      end
    end
  end
end
