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

The official gem is somewhat lackign in functionality, though with the demise of Mandrill it seems SparkPost may have decided to restart development on it.

But, not being in a mood to wait, and as we would have to write wrappers around all the functions we would need anyway, it seemed much easier to write the wrapper as a gem and allow others to use it too.

The official gem currently only supports the send_message (create) method of /transmissions and it does it with a limited argument set. As it uses method parameters for each of the arguments it supports, it is not possible to use all the functionality the SparkPost API has. This gem will allow passing the parameters as hashes, allowing you to directly copy an API example into code and take full advantage of all the API functions.

### Status

It's day one, and it's a day one project.


## Contributing

Not right now, but in time ...

1. Fork it ( https://github.com/leadmachineapp/simple_spark/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
