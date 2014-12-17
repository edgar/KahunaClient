# KahunaClient [![Build Status](https://travis-ci.org/edgar/KahunaClient.png?branch=master)](https://travis-ci.org/edgar/KahunaClient) [![Gem Version](https://badge.fury.io/rb/kahuna_client.svg)](http://badge.fury.io/rb/kahuna_client)
A ruby gem for the Kahuna Push API - https://app.usekahuna.com/tap/getstarted/pushapi/

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'kahuna_client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kahuna_client


## API Usage Examples

```ruby
require "rubygems"
require "kahuna_client"

client = KahunaClient::Client.new(secret_key: 'your secret key', api_key: 'your api key')

push_object = {
  target: {
      username: "iamawesome1989",
      email: "awesome@mail.com",
      fbid: "42",
      user_id: "789"
  },
  notification: {
      alert: "Look at this Push!"
  },
  params: {
      sale_id: "1234",
      landing_page: "share_page"
  },
  config: {
      start_time: 1382652322,
      optimal_hours: 8,
      influence_rate_limiting: true,
      observe_rate_limiting: true
  }
}

# Send the pushes (one or more)
client.push([push_object])
```

For more information about extra parameters and error conditions check the specs folder

## Configuration

Because KahunaClient gem is based on [Faraday](https://github.com/lostisland/faraday), it supports the following adapters:

* Net::HTTP (default)
* [Excon](https://github.com/geemus/excon)
* [Typhoeus](https://github.com/typhoeus/typhoeus)
* [Patron](http://toland.github.com/patron/)
* [EventMachine](https://github.com/igrigorik/em-http-request)

Beside the adapter, you can change the following properties:

* endpoint
* user_agent
* proxy
* debug
* environment

For instance:

```ruby
require 'typhoeus/adapters/faraday' # You will need the typhoeus gem

client = KahunaClient.client(adapter: :typhoeus, user_agent: "foobar v1", debug: true, secret_key: 'foo', api_key: 'bar')
client.push(push_array)
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
