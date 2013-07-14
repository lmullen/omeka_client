require "minitest/autorun"
require "omeka_client"

describe OmekaClient::Client do

  # Setup a test client
  test_endpoint = "http://localhost/omeka-2.1-rc1/api"
  test_api_key = "c56c8f542bc98483b71896523d4faa6321de193b"
  resources = ["items", "collections"]
  client = OmekaClient::Client.new(test_endpoint, test_api_key)

  it "must have an endpoint" do
    client.endpoint.must_equal test_endpoint
  end

  it "can be created without an API key" do
    keyless = OmekaClient::Client.new(test_endpoint)
    keyless.api_key.must_be_nil
  end

  it "can be created with an API key" do
    client.api_key.must_equal test_api_key
  end

  it "must successfully request items and collections " do
    resources = ["items", "collections"]
    resources.each do |resource|
      client.get(resource).code.must_equal 200
    end
  end

  it "must successfully request a single item or collection" do
    resources.each do |resource|
      client.get(resource, 1).code.must_equal 200
    end
  end

  it "must return a persistent wrapper for a GET request" do
    resources.each do |resource|
      client.get(resource).must_be_instance_of \
      Rest::Wrappers::NetHttpPersistentResponseWrapper
    end
  end

  it "must return a hash or array for a GET request" do
    resources.each do |resource|
      client.get_hash(resource).must_be_instance_of Array || Hash
    end
  end

  it "must return a representation of the site description" do
    client.site['title'].wont_be_nil
  end

  it "must list the resources available via the API" do
    client.resources.must_be_instance_of Hash
    client.resources.wont_be_empty
  end

  it "must list the items available via the API" do
    client.items.must_be_instance_of Array
    client.items.wont_be_empty
  end

  it "must list the collections available via the API" do
    client.collections.must_be_instance_of Array
    client.collections.wont_be_empty
  end

  it "must return an OmekaItem class" do
    puts client.omeka_items(1).must_be_instance_of OmekaClient::OmekaItem
  end

end
