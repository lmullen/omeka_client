# OmekaClient

A REST client for [Omeka][], using the API introduced in Omeka 2.1.

Lincoln Mullen | lincoln@lincolnmullen.com | http://lincolnmullen.com

## Installation

Add this line to your application's Gemfile:

    gem 'omeka_client'

And then execute:

    bundle install

Or install it yourself:

    gem install omeka_client

## Usage

See the [Omeka API documentation][] for information about what is possible with the Omeka's API.

First, load the gem in your script:

    require "omeka_client"

Next, create a client to interact with your Omeka site. You'll need your endpoint and, optionally, an API key.

    client = OmekaClient::Client.new(http://localhost/omeka/api, "api_key")
    # => #<OmekaClient::Client:0x007f4307937aa0>

You can use the convenience methods for easy access to data.

    site_info = client.site
    puts site_info['title']
    # => Omeka RC Dev

    items = client.items
    puts items[0]['id']
    # => 1
    puts items[0]['url']
    # => http://localhost/omeka/api/items/1

If you want more flexibility, you can use the higher level methods.

    client.get('collections', 1)

    client.get_hash('collections', 1)

If you just want a raw REST connection to Omeka, then you can access the underlying instance from the [Rest gem][].

    client.connection

## Testing and documentation

You can run the tests by running `rake test`. You'll need to have an Omeka site running at least 2.1-RC1 to use the tests.

You can generate the documentation by running `rake yard`.

## Future plans

For now the gem only handles GET requests. I'm going to work on making methods that pull information out of Omeka as robust as possible before I deal with POST, PUT, and DELETE. Contributions are more than welcome.

## License

This gem is licensed under the [GPLv3][], the same as Omeka.

## Thanks

This gem is based on Jim Safely's [sample client][] for Python. And of course many thanks to all the amazing [Omeka developers][].

  [Omeka]: http://omeka.org
  [Omeka API documentation]: http://omeka.readthedocs.org/en/latest/Reference/api/
  [Rest gem]: https://github.com/iron-io/rest
  [GPLv3]: http://www.gnu.org/licenses/gpl-3.0.html
  [sample client]: https://github.com/jimsafley/omeka-client-py
  [Omeka developers]: http://omeka.org/about/staff/
