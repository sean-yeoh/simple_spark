module SimpleSpark
  # Provides access to the /templates endpoint
  # See: https://developers.sparkpost.com/api/#/reference/templates
  class Templates
    attr_accessor :client

    def initialize(client)
      @client = client
    end

    # Lists the most recent version of each template in your account.
    # Each template object in the list will have the following fields:
    #   id: Unique template ID
    #   name: Template name
    #   published: Published state of the template (true = published, false = draft)
    #   description: Template description
    # See: https://developers.sparkpost.com/api/#/reference/templates/create-and-list/list-all-templates
    def list
      @client.call(:get, 'templates')
    end
  end
end
