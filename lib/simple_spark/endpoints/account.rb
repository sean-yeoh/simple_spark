module SimpleSpark
  module Endpoints
    # Provides access to the /account endpoint
    # @note See: https://developers.sparkpost.com/api/#/reference/account
    class Account
      attr_accessor :client

      def initialize(client)
        @client = client
      end

      # Get your SparkPost account information, including subscription status and quota usage.
      # @param include_values [String] Additional parts of account details to include.
      #   Multiple parts can be specified in a comma separated list.
      #   The only valid value is currently usage and by default the usage details are not included.
      # @return [Hash] an account information hash object
      # @note See: https://developers.sparkpost.com/api/#/reference/account/retrieve-get
      def retrieve(include_values = nil)
        query_params = include_values.nil? ? {} : { include: include_values }
        @client.call(method: :get, path: 'account', query_values: query_params)
      end

      # Update your SparkPost account information and account-level options.
      # @param values [Hash] Request Body Attributes
      #   company_name [String] company name
      #   options [Hash] account-level options
      #     smtp_tracking_default [Boolean] set to true to turn on SMTP engagement tracking by default
      #     rest_tracking_default [Boolean] set to false to turn off REST API engagement tracking by default
      #     transactional_unsub [Boolean] set to true to include List-Unsubscribe header for all transactional messages by default
      #     transactional_default [Boolean] set to true to send messages as transactional by default
      # @return { results: { message: "Account has been updated" } }
      # @note See: https://developers.sparkpost.com/api/#/reference/account/update-put
      # @note Example:
      #   values = {
      #     company_name: "SparkPost",
      #     options: {
      #       smtp_tracking_default: true
      #     }
      #   }
      def update(values = {})
        @client.call(method: :put, path: 'account', body_values: values)
      end
    end
  end
end
