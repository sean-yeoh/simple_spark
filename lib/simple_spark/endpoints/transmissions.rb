module SimpleSpark
  module Endpoints
    # Provides access to the /transmissions endpoint
    # See: https://developers.sparkpost.com/api/#/reference/transmissions
    class Transmissions
      attr_accessor :client

      def initialize(client)
        @client = client
      end

      # Sends an email message
      # @param values [Hash] the values to send with. This can be a complex object depending on the options chosen.
      # @param num_rcpt_errors [Integer] limit the number of recipient errors returned. Will default to all
      # @returns { results: { total_rejected_recipients: 0, total_accepted_recipients: 1, id: "11668787484950529" } }
      # @note See: https://developers.sparkpost.com/api/#/reference/transmissions/create
      # @note Example:
      #   properties = {
      #     options: { open_tracking: true, click_tracking: true },
      #     campaign_id: 'christmas_campaign',
      #     return_path: 'bounces-christmas-campaign@sp.neekme.com',
      #     metadata: {user_type: 'students'},
      #     substitution_data: { sender: 'Big Store Team' },
      #     recipients:  [
      #       { address: { email: 'yourcustomer@theirdomain.com', name: 'Your Customer' },
      #         tags: ['greeting', 'sales'],
      #         metadata: { place: 'Earth' }, substitution_data: { address: '123 Their Road' } }
      #     ],
      #     content:
      #     { from: { name: 'Your Name', email: 'you@yourdomain.com' },
      #       subject: 'I am a test email',
      #       reply_to: 'Sales <sales@yourdomain.com>',
      #       headers: { 'X-Customer-CampaignID' => 'christmas_campaign' },
      #       text: 'Hi from {{sender}} ... this is a test, and here is your address {{address}}',
      #       html: '<p>Hi from {{sender}}</p><p>This is a test</p>'
      #     }
      #   }
      #
      # Or to use a template, change the content key to be:
      # content: { template_id: 'first-template-id' }
      def create(values, num_rcpt_errors = nil)
        query_params = num_rcpt_errors.nil? ? {} : { num_rcpt_errors: num_rcpt_errors }
        @client.call(method: :post, path: 'transmissions', body_values: values, query_values: query_params)
      end

      # Sends an email message
      # @param campaign_id [String] limit results to this Campaign ID
      # @param template_id [String] limit results to this Template ID
      # @returns [ { "content": { "template_id": "winter_sale" }, "id": "11713562166689858",
      #   "campaign_id": "thanksgiving", "description": "", "state": "submitted" } ]
      # @note See: https://developers.sparkpost.com/api/#/reference/transmissions/list
      def list(campaign_id = nil, template_id = nil)
        query_params = {}
        query_params[:campaign_id] = campaign_id if campaign_id
        query_params[:template_id] = template_id if template_id
        @client.call(method: :get, path: 'transmissions', query_values: query_params)
      end

      # Deletes all transmissions for a given campaign
      # @param campaign_id [String] specifies the campaign to delete transmissions for
      # @returns empty string
      # @note Endpoint returns empty response body with 204 status code
      def delete_campaign(campaign_id)
        @client.call(method: :delete, path: 'transmissions', query_values: { campaign_id: campaign_id })
      end

      # send_message to be reserved as a 'quick' helper method to avoid using hash for Create
      # alias_method :send_message, :create
    end
  end
end
