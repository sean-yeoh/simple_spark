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

    # Create a template by providing values for the template object.
    # At a minimum, the "name" and "content" fields are required, where content must contain
    # the "from", "subject", and at least one of "html" or "text" fields.
    # https://developers.sparkpost.com/api/#/reference/templates/create-a-template
    def create(values)
      @client.call(:post, 'templates', values)
    end

    # id: Unique Template ID to retrieve
    # draft: If true, returns the most recent draft template.
    #        If false, returns the most recent published template.
    #        If not provided, returns the most recent template version regardless of draft or published.
    #
    # Sample Template
    # {"id"=>"102293692714480130", "name"=>"Summer Sale!", "description"=>"", "published"=>false, "options"=>{},
    #  "last_update_time"=>"2016-03-02T22:49:23+00:00",
    #  "content"=>{"from"=>"marketing@neekme.com", "subject"=>"Summer deals", "html"=>"<b>Check out these deals!</b>"}}
    #
    # https://developers.sparkpost.com/api/#/reference/templates/retrieve/retrieve-a-template
    def retrieve(id, draft = nil)
      path = "templates/#{id}"
      path += "?draft=#{draft}" unless draft.nil?
      @client.call(:get, path)
    end

    # id: Unique Template ID to update
    # values: Hash of the values to update the template with
    # update_published: If true, directly overwrite the existing published template. If false, create a new draft.
    #                   If this template isn't yet published, setting to 'true' will result in a NotFound error
    #
    # https://developers.sparkpost.com/api/#/reference/templates/update/update-a-template
    def update(id, values, update_published = false)
      path = "templates/#{id}?update_published=#{update_published}"
      @client.call(:put, path, values)
    end

    # id: Unique Template ID to preview
    # values: substitution data to preview with
    #         { "substitution_data" => { "name" => "Natalie", "age" => 35, "member" => true }
    # draft: If true, returns the most recent draft template.
    #        If false, returns the most recent published template.
    #        If not provided, returns the most recent template version regardless of draft or published.
    #
    # https://developers.sparkpost.com/api/#/reference/templates/update/preview-a-template
    def preview(id, values, draft = nil)
      path = "templates/#{id}/preview"
      path += "?draft=#{draft}" unless draft.nil?
      @client.call(:post, path, values)
    end

    # id: Unique Template ID to delete
    # values: Hash of the values to update the template with
    # update_published: If true, directly overwrite the existing published template. If false, create a new draft.
    #                   If this template isn't yet published, setting to 'true' will result in a NotFound error
    #
    # https://developers.sparkpost.com/api/#/reference/templates/update/update-a-template
    def delete(id)
      @client.call(:delete, "templates/#{id}")
    end
  end
end
