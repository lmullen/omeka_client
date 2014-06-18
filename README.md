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

See the [Omeka API documentation][] for information about what is
possible with the Omeka's API.

First, load the gem in your script:

    require "omeka_client"

Next, create a client to interact with your Omeka site. You'll need your
endpoint and, optionally, an API key.

    client = OmekaClient::Client.new("http://localhost/omeka/api", "api_key")
    # => #<OmekaClient::Client:0x007f4307937aa0>

### High Level Methods

You can read Omeka items using the following methods:

    item = client.get_item(1)
    # Returns a single item

    client.get_all_items
    # Returns an array of all the items 

Each item is represented by a Ruby object. You can access the Dublin
Core, Item Type, and basic metadata through methods

    item.data.id
    # => 1

    item.data.public
    # => true

    item.data.added
    # => "2013-07-13T04:47:08+00:00"

But since the data you probably want most are the element texts for
either the Dublin Core Metadata or the Item Type Metadata, they can be
accessed through methods of this type:

    item.dublin_core.title
    # => "Questions of the Soul"

    item.dublin_core.creator
    # => "Hecker, Isaac Thomas, 1819-1888."

    item.item_type_metadata.binding
    # => "cloth"

    item.item_type_metadata.signature
    # => "signed by author"

There are some helper methods to get other kinds of information from the
API:

    client.get_collection
    client.get_all_collections

    client.get_site
    client.get_site.data.title
    # => "Omeka Development Site"

Once you have an Omeka item, you can update it on the site, create a new
item on the site, or delete it from the site. See the documentation for
these functions.

    # Create a new item (your local Ruby item will not point to this new item)
    client.post_item(item)

    # Update an item
    item.dublin_core.title = "Updated via API"
    client.put_item(item)

    # Delete an item
    client.delete_item(item)

### Low Level Methods

If you want more flexibility about what you're requesting, you can use
the lower-level methods. These basic PUT, POST, DELETE, and PUT methods
return wrappers around the HTTP response.

    client.get('items', 1)
    # => #<Rest::Wrappers::NetHttpPersistentResponseWrapper:0x007fe14ba72ae0 @response=#<Net::HTTPOK 200 OK readbody=true>, @tries=1>

    client.get('items', 1).code
    # => 200

    client.get('items', 1).body
    # returns the JSON representation of the item

See the documentation for each method. You can send information to the
Omeka site using the low-level methods `client.push`, `client.put`, and
`client.delete`. These methods each takes a JSON object.

If you just want a raw REST connection to Omeka, then you can access the
underlying instance from the [Rest gem][].

    client.connection

## Testing and documentation

You can run the tests by running `rake test`. You'll need to have an
Omeka site running at least 2.1 to use the tests.

You can generate the documentation by running `rake yard`.

## License

This gem is licensed under the [GPLv3][], the same as Omeka.

## Thanks

This gem is based on Jim Safley's [sample client][] for Python. And of
course many thanks to all the amazing [Omeka developers][].

  [Omeka]: http://omeka.org
  [Omeka API documentation]: http://omeka.readthedocs.org/en/latest/Reference/api/
  [Rest gem]: https://github.com/iron-io/rest
  [GPLv3]: http://www.gnu.org/licenses/gpl-3.0.html
  [sample client]: https://github.com/jimsafley/omeka-client-py
  [Omeka developers]: http://omeka.org/about/staff/
