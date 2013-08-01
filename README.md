# Omeka Client

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

    client = OmekaClient::Client.new("http://localhost/omeka/api", "api_key")
    # => #<OmekaClient::Client:0x007f4307937aa0>

You can use the convenience methods for easy access to data. The most useful methods return classes that represent OmekaItems.

    item = client.omeka_items(1)

Now you can access every piece of information returned by the Omeka API through the `data` variable.

    item.data.id
    # => 1
    item.data.public
    # => true
    item.data.added
    # => "2013-07-13T04:47:08+00:00"

But since the data you probably want most are the element texts for either the Dublin Core Metadata or the Item Type Metadata, they can be accessed through methods of this type:

    item.dc_title
    # => "Questions of the Soul"
    item.dc_author
    # => "Hecker, Isaac Thomas, 1819-1888."
    item.itm_binding
    # => "cloth"
    item.itm_signature
    # => "signed by author"

There are some helper methods to get other results in other forms:

    site_info = client.site
    puts site_info['title']
    # => Omeka RC Dev

    items = client.items
    puts items[0]['id']
    # => 1
    puts items[0]['url']
    # => http://localhost/omeka/api/items/1

Once you have an Omeka item, you can update it on the site, create a new item on the site, or delete it from the site.

    # Create a new item (your local Ruby item will not point to this new item)
    client.post_item(item)

    # Update an item
    item.dc_title = "Updated via API"
    client.put_item(item)

    # Delete an item
    client.delete_item(item)

If you want more flexibility about what you're requesting, you can use the lower-level methods.

    client.get('collections', 1)

    client.get_hash('collections', 1)

You can send information to the Omeka site using the low-level methods `client.push`, `client.put`, and `client.delete`. These methods each takes a JSON object.

If you just want a raw REST connection to Omeka, then you can access the underlying instance from the [Rest gem][].

    client.connection

## Testing and documentation

You can run the tests by running `rake test`. You'll need to have an Omeka site running at least 2.1-RC1 to use the tests.

You can generate the documentation by running `rake yard`.

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
