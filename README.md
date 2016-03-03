# SimpleSpark

[![Build Status](https://travis-ci.org/leadmachineapp/simple_spark.png?branch=master)](https://travis-ci.org/leadmachineapp/simple_spark)

This gem is an alternative to the [official Ruby gem](https://github.com/SparkPost/ruby-sparkpost) provided by [SparkPost](http://www.sparkpost.com)

## Installation

Add this line to your application's Gemfile:

    gem 'simple_spark'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install simple_spark

## Usage

### Why?

The official gem is somewhat lacking in functionality, though with the demise of Mandrill it seems SparkPost may have decided to restart development on it.

But, not being in a mood to wait, and as we would have to write wrappers around all the functions we would need anyway, it seemed much easier to write the wrapper as a gem and allow others to use it too.

The official gem currently only supports the send_message (create) method of /transmissions and it does it with a limited argument set. As it uses method parameters for each of the arguments it supports, it is not possible to use all the functionality the SparkPost API has. This gem will allow passing the parameters as hashes, allowing you to directly copy an API example into code and take full advantage of all the API functions.

### Status

It's day one, and it's a day one project.


## Endpoints

### Inbound Domains

    require 'simple_spark'
    client = SimpleSpark::Client.new('your_api_token')

#### List

List all Inbound Domains

    client.inbound_domains.list

#### Create

Create a new Inbound Domain

    client.inbound_domains.create('mail.mydomain.com')

#### Retrieve

Retrieves an Inbound Template by its domain name

    client.inbound_domains.retrieve('mail.mydomain.com')

#### Delete

Deletes an Inbound Domain permanently

    client.inbound_domains.delete('mail.mydomain.com')

### Templates

    require 'simple_spark'
    client = SimpleSpark::Client.new('your_api_token')

#### List

List all templates

    client.templates.list

#### Create

Create a new Template

    properties = {  "name" => "Summer Sale!", "content"=> { "from" => "marketing@yourdomain.com",   "subject"=> "Summer deals",  "html"=> "<b>Check out these deals!</b>"}}
    client.templates.create(properties)

#### Retrieve

Retrieves a Template by its ID

    draft = nil
    client.templates.retrieve(yourtemplateid, draft)

#### Update

Udpates a Template with new values

    properties = { "name" => "Sorry, the Winter Sale!" }}
    update_published = false
    client.templates.update(yourtemplateid, properties, update_published)

#### Preview

Merges the template with the Substitution data and returns the result

    properties = { substitution_data: { name: 'Mr test User' } }
    draft = nil
    client.templates.preview(yourtemplateid, properties, draft)

#### Delete

Deletes a template permanently

    client.templates.delete(yourtemplateid)


## Contributing

Not right now, but in time ...

1. Fork it ( https://github.com/leadmachineapp/simple_spark/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
