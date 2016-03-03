module SimpleSpark
  module Endpoints
    # Provides access to the /templates endpoint
    # See: https://developers.sparkpost.com/api/#/reference/templates
    class InboundDomains
      attr_accessor :client

      def initialize(client)
        @client = client
      end

      # Lists your inbound domains
      #
      # [ { "domain": "inbounddomain.test.com" }, { "domain": "inbounddomain2.test.com" } ]
      #
      # See: https://developers.sparkpost.com/api/#/reference/inbound-domains/list-all-inbound-domains
      def list
        @client.call(:get, 'inbound-domains')
      end

      # Create an inbound domain
      # domain_name: the domain name to create
      #
      # See: https://developers.sparkpost.com/api/#/reference/inbound-domains/create-and-list/create-an-inbound-domain
      def create(domain_name)
        @client.call(:post, 'inbound-domains', { domain: domain_name })
      end

      # Retrieve an inbound domain
      # domain_name: the domain name to delete
      #
      # Response: { domain: domain_name }
      #
      # See: https://developers.sparkpost.com/api/#/reference/inbound-domains/create-and-list/retrieve-an-inbound-domain
      def retrieve(domain_name)
        domain_name = @client.url_encode(domain_name)
        @client.call(:get, "inbound-domains/#{domain_name}")
      end

      # Delete an inbound domain
      # domain_name: the domain name to delete
      #
      # See: https://developers.sparkpost.com/api/#/reference/inbound-domains/retrieve-and-delete/delete-an-inbound-domain
      def delete(domain_name)
        domain_name = @client.url_encode(domain_name)
        @client.call(:delete, "inbound-domains/#{domain_name}")
      end
    end
  end
end
