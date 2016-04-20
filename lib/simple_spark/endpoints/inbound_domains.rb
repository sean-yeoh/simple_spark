module SimpleSpark
  module Endpoints
    # Provides access to the /inbound-domains endpoint
    # See: https://developers.sparkpost.com/api/#/reference/inbound-domains
    class InboundDomains
      attr_accessor :client

      def initialize(client)
        @client = client
      end

      # Lists your inbound domains
      # @return [Array] a list of Inbound Domain hash objects
      # @note See: https://developers.sparkpost.com/api/#/reference/inbound-domains/create-and-list
      def list
        @client.call(method: :get, path: 'inbound-domains')
      end

      # Create an inbound domain
      # @param domain_name [String] the domain name to create
      # @note See: https://developers.sparkpost.com/api/#/reference/inbound-domains/create-and-list
      def create(domain_name)
        @client.call(method: :post, path: 'inbound-domains', query_values: { domain: domain_name })
      end

      # Retrieve an inbound domain
      # @param domain_name [String] the domain name to retrieve
      # @return [Hash] an Inbound Domain hash object
      # @note See: https://developers.sparkpost.com/api/#/reference/inbound-domains/retrieve-and-delete
      def retrieve(domain_name)
        domain_name = @client.url_encode(domain_name)
        @client.call(method: :get, path: "inbound-domains/#{domain_name}")
      end

      # Delete an inbound domain
      # @param domain_name [String] the domain name to delete
      # @note See: https://developers.sparkpost.com/api/#/reference/inbound-domains/retrieve-and-delete
      def delete(domain_name)
        domain_name = @client.url_encode(domain_name)
        @client.call(method: :delete, path: "inbound-domains/#{domain_name}")
      end
    end
  end
end
