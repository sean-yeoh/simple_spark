module SimpleSpark
  module Endpoints
    # Provides access to the /sending-domains endpoint
    # @note Example sending domain
    #   { "domain": "example1.com", "tracking_domain": "click.example1.com",
    #   "status": { "ownership_verified": true, "spf_status": "valid", "abuse_at_status": "valid",
    #   "abuse_at_status": "valid", "dkim_status": "valid", "compliance_status": "valid", "postmaster_at_status": "valid" } }
    # @note See: https://developers.sparkpost.com/api/#/reference/sending-domains
    class SendingDomains
      attr_accessor :client

      def initialize(client)
        @client = client
      end

      # Lists your sending domains
      # @return [Array] a list of Sending Domain hash objects
      # @note See: https://developers.sparkpost.com/api/#/reference/sending-domains/create-and-list/list-all-sending-domains
      def list
        @client.call(:get, 'sending-domains')
      end

      # Create a sending domain
      # @param domain_name [String] the domain name to create
      # @param tracking_domain [String] the domain name to track this domain against
      # @note See: https://developers.sparkpost.com/api/#/reference/sending-domains/create-and-list
      def create(values)
        @client.call(:post, 'sending-domains', values)
      end

      # Retrieve a sending domain
      # @param domain_name [String] the domain name to retrieve
      # @return [Hash] an Sending Domain hash object
      # @note See: https://developers.sparkpost.com/api/#/reference/sending-domains/retrieve-update-and-delete
      def retrieve(domain_name)
        domain_name = @client.url_encode(domain_name)
        @client.call(:get, "sending-domains/#{domain_name}")
      end

      # Update a Sending Domain by its domain name
      # @param domain_name [String] the domain to update
      # @param values [Hash] the values to update the sending domain with
      #
      # @note See: https://developers.sparkpost.com/api/#/reference/sending-domains/retrieve-update-and-delete
      def update(domain_name, values)
        domain_name = @client.url_encode(domain_name)
        @client.call(:put, "sending-domains/#{domain_name}", values)
      end

      # Verify a Sending Domain by its domain name
      # @param domain_name [String] the domain to verify
      # @param values [Hash] the values specifying how to verify the domain
      #   Including the fields "dkim_verify" and/or "spf_verify" in the request initiates a check against the associated DNS record
      #   type for the specified sending domain.Including the fields "postmaster_at_verify" and/or "abuse_at_verify" in the request
      #   results in an email sent to the specified sending domain's postmaster@ and/or abuse@ mailbox where a verification link can
      #   be clicked.Including the fields "postmaster_at_token" and/or "abuse_at_token" in the request initiates a check of the provided
      #   token(s) against the stored token(s) for the specified sending domain.
      #
      # @note See: https://developers.sparkpost.com/api/#/reference/sending-domains/verify
      def verify(domain_name, values)
        domain_name = @client.url_encode(domain_name)
        @client.call(:post, "sending-domains/#{domain_name}/verify", values)
      end

      # Delete a sending domain
      # @param domain_name [String] the domain name to delete
      # @note See: https://developers.sparkpost.com/api/#/reference/sending-domains/retrieve-update-and-delete
      def delete(domain_name)
        domain_name = @client.url_encode(domain_name)
        @client.call(:delete, "sending-domains/#{domain_name}")
      end
    end
  end
end
