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

### Creating a Client

First you need to ensure you are requiring the library

    require 'simple_spark'

The simplest version of the client is to just provide your [API key from SparkPost](https://app.sparkpost.com/account/credentials)

    client = SimpleSpark::Client.new('your_api_key')

You can also use ENV vars to configure the key, setting ENV['SPARKPOST_API_KEY'] will allow you to just use

    client = SimpleSpark::Client.new

You can also override the other options if you need to in advanced scenarios, the full signature is

    client = SimpleSpark::Client.new('your_api_key', api_host = 'https://api.sparkpost.com', base_path = '/api/v1/' , debug = false)

Setting debug to true will cause [Excon](https://github.com/excon/excon) to output full debug information to the log, to default the other values and just set debug, send nil values

    client = SimpleSpark::Client.new(nil, nil, nil, true)

### Transmissions

#### List

List all Transmissions

When messages are sent the Transmission will be deleted, so this will only return transmissions that are about to be sent or are scheduled for the future

    client.transmissions.list

<small><a href="https://developers.sparkpost.com/api/#/reference/transmissions/list" target="_blank">see SparkPost API Documentation</a></small>

#### Create

Create a new Transmission

    properties = {
      options: { open_tracking: true, click_tracking: true },
      campaign_id: 'christmas_campaign',
      return_path: 'bounces-christmas-campaign@sp.neekme.com',
      metadata: {user_type: 'students'},
      substitution_data: { sender: 'Big Store Team' },
      recipients:  [
        { address: { email: 'yourcustomer@theirdomain.com', name: 'Your Customer' },
          tags: ['greeting', 'sales'],
          metadata: { place: 'Earth' }, substitution_data: { address: '123 Their Road' } }
      ],
      content:
      { from: { name: 'Your Name', email: 'you@yourdomain.com' },
        subject: 'I am a test email',
        reply_to: 'Sales <sales@yourdomain.com>',
        headers: { 'X-Customer-CampaignID' => 'christmas_campaign' },
        text: 'Hi from {{sender}} ... this is a test, and here is your address {{address}}',
        html: '<p>Hi from {{sender}}</p<p>This is a test</p>'
      }
    }

    client.transmissions.create(properties)

<small><a href="https://developers.sparkpost.com/api/#/reference/transmissions/create" target="_blank">see SparkPost API Documentation</a></small>

### Sending Domains

#### List

List all Sending Domains

    client.sending_domains.list

<small><a href="https://developers.sparkpost.com/api/#/reference/sending-domains/create-and-list" target="_blank">see SparkPost API Documentation</a></small>

#### Create

Create a new Sending Domain

    client.sending_domains.create('mail.mydomain.com')

<small><a href="https://developers.sparkpost.com/api/#/reference/sending-domains/create-and-list" target="_blank">see SparkPost API Documentation</a></small>

#### Retrieve

Retrieves a Sending Template by its domain name

    client.sending_domains.retrieve('mail.mydomain.com')

<small><a href="https://developers.sparkpost.com/api/#/reference/sending-domains/retrieve-update-and-delete" target="_blank">see SparkPost API Documentation</a></small>

#### Update

Updates a Sending Domain with new values

    properties = { "tracking_domain" => "new.tracking.domain" }
    client.sending_domains.update('mail.mydomain.com', properties)

<small><a href="https://developers.sparkpost.com/api/#/reference/sending-domains/retrieve-update-and-delete" target="_blank">see SparkPost API Documentation</a></small>

#### Verify

Forces verification of a Sending Domain.

Including the fields "dkim_verify" and/or "spf_verify" in the request initiates a check against the associated DNS record
type for the specified sending domain.Including the fields "postmaster_at_verify" and/or "abuse_at_verify" in the request
results in an email sent to the specified sending domain's postmaster@ and/or abuse@ mailbox where a verification link can
be clicked. Including the fields "postmaster_at_token" and/or "abuse_at_token" in the request initiates a check of the provided
token(s) against the stored token(s) for the specified sending domain.

    properties = { "dkim_verify": true, "spf_verify": true }
    client.sending_domains.retrieve('mail.mydomain.com', properties)

<small><a href="https://developers.sparkpost.com/api/#/reference/sending-domains/verify" target="_blank">see SparkPost API Documentation</a></small>

#### Delete

Deletes a Sending Domain permanently

    client.sending_domains.delete('mail.mydomain.com')

<small><a href="https://developers.sparkpost.com/api/#/reference/sending-domains/retrieve-update-and-delete" target="_blank">see SparkPost API Documentation</a></small>

### Inbound Domains

#### List

List all Inbound Domains

    client.inbound_domains.list

<small><a href="https://developers.sparkpost.com/api/#/reference/inbound-domains/create-and-list" target="_blank">see SparkPost API Documentation</a></small>

#### Create

Create a new Inbound Domain

    client.inbound_domains.create('mail.mydomain.com')

<small><a href="https://developers.sparkpost.com/api/#/reference/inbound-domains/create-and-list" target="_blank">see SparkPost API Documentation</a></small>

#### Retrieve

Retrieves an Inbound Template by its domain name

    client.inbound_domains.retrieve('mail.mydomain.com')

<small><a href="https://developers.sparkpost.com/api/#/reference/inbound-domains/retrieve-and-delete" target="_blank">see SparkPost API Documentation</a></small>

#### Delete

Deletes an Inbound Domain permanently

    client.inbound_domains.delete('mail.mydomain.com')

<small><a href="https://developers.sparkpost.com/api/#/reference/inbound-domains/retrieve-and-delete" target="_blank">see SparkPost API Documentation</a></small>

### Templates

#### List

List all templates

    client.templates.list

<small><a href="https://developers.sparkpost.com/api/#/reference/templates/create-and-list" target="_blank">see SparkPost API Documentation</a></small>

#### Create

Create a new Template

    properties = {  "name" => "Summer Sale!", "content"=> { "from" => "marketing@yourdomain.com",   "subject"=> "Summer deals",  "html"=> "<b>Check out these deals!</b>"}}
    client.templates.create(properties)

<small><a href="https://developers.sparkpost.com/api/#/reference/templates/create-and-list" target="_blank">see SparkPost API Documentation</a></small>

#### Retrieve

Retrieves a Template by its ID

    draft = nil
    client.templates.retrieve(yourtemplateid, draft)

<small><a href="https://developers.sparkpost.com/api/#/reference/templates/retrieve" target="_blank">see SparkPost API Documentation</a></small>

#### Update

Updates a Template with new values

    properties = { "name" => "Sorry, the Winter Sale!" }}
    update_published = false
    client.templates.update(yourtemplateid, properties, update_published)

<small><a href="https://developers.sparkpost.com/api/#/reference/templates/update" target="_blank">see SparkPost API Documentation</a></small>

#### Preview

Merges the template with the Substitution data and returns the result

    properties = { substitution_data: { name: 'Mr test User' } }
    draft = nil
    client.templates.preview(yourtemplateid, properties, draft)

<small><a href="https://developers.sparkpost.com/api/#/reference/templates/preview" target="_blank">see SparkPost API Documentation</a></small>

#### Delete

Deletes a template permanently

    client.templates.delete(yourtemplateid)

<small><a href="https://developers.sparkpost.com/api/#/reference/templates/delete" target="_blank">see SparkPost API Documentation</a></small>

## Contributing

Not right now, but in time ...

1. Fork it ( https://github.com/leadmachineapp/simple_spark/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
