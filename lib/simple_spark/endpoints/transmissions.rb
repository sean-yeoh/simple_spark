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
     # @note See: https://developers.sparkpost.com/api/#/reference/transmissions/create/create-a-transmission
     # @note JSON.parse('{ "options": { "open_tracking": true, "click_tracking": true  }, "campaign_id": "christmas_campaign", "return_path": "bounces-christmas-campaign@flintstone.com", "metadata": { "user_type": "students" }, "substitution_data": { "sender": "Big Store Team" }, "recipients": [ { "address": { "email": "jakcharlton@gmail.com", "name": "jak Charlton" }, "tags": [ "greeting", "prehistoric", "fred", "flintstone" ], "metadata": { "place": "Bedrock" }, "substitution_data": { "customer_type": "Platinum" }    }  ],  "content": {    "from": { "name": "Jak Charlton", "email": "fred@neekme.com"    },    "subject": "I am a clean test",    "reply_to": "Neekme Sales <sales@neekme.com>",    "headers": { "X-Customer-Campaign-ID": "christmas_campaign"    },    "text": "Hi Jak ... this is text to test",    "html": "<p>Hi Jak, this is a test to try and show the spam was a context issue</p>"  }}'

     def create(values, num_rcpt_errors = nil)
       query_params = num_rcpt_errors.nil? ? {} : { num_rcpt_errors: num_rcpt_errors }
       @client.call(:post, 'transmissions', values, query_params)
     end

     # Sends an email message
     # @param campaign_id [String] limit results to this Campaign ID
     # @param template_id [String] limit results to this Template ID
     # @returns [ { "content": { "template_id": "winter_sale" }, "id": "11713562166689858",
     #   "campaign_id": "thanksgiving", "description": "", "state": "submitted" } ]
     # @note See: https://developers.sparkpost.com/api/#/reference/transmissions/create/create-a-transmission
     def list(campaign_id = nil, template_id = nil)
       query_params = {}
       query_params[:campaign_id] = campaign_id if campaign_id
       query_params[:template_id] = template_id if template_id
       @client.call(:get, 'transmissions', {}, query_params)
     end

     alias_method :send_message, :create
    end
  end
end
