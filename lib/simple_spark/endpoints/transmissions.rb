module SimpleSpark
  module Endpoints
    # Provides access to the /transmissions endpoint
    # See: https://developers.sparkpost.com/api/#/reference/transmissions
    class Transmissions
      attr_accessor :client

      def initialize(client)
        @client = client
      end

      # Sends a message to SparkPost
      # See: https://developers.sparkpost.com/api/#/reference/transmissions/create/create-a-transmission
      def create(data)
        @client.call(:post, 'transmissions', data)
      end

      alias_method :send_message, :create
    end
  end
end
