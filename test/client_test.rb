require "minitest/autorun"
require "omeka_client"

describe OmekaClient::Client do

  # Setup a test client
  test_endpoint = "http://localhost/omeka-2.1-rc1/api"
  test_api_key  = "3b036221e180af46bafa4b5e4a1db30e84e78e89"    # contributor
  resources     = ["items", "collections"]
  client        = OmekaClient::Client.new(test_endpoint, test_api_key)

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
   client.omeka_items(1).must_be_instance_of OmekaClient::OmekaItem
 end

  it "must return an array of OmekaItem classes" do
    client.omeka_items.must_be_instance_of Array
    [0,1].each do |number|
      client.omeka_items[number].must_be_instance_of \
      OmekaClient::OmekaItem
    end
  end

  it "must be able to POST an item and then DELETE it" do
    body = '{"public":true,"featured":false,"element_texts":[{"html":false,"text":"Item Added via API","element_set":{"id":1,"url":"http:\/\/localhost\/omeka-2.1-rc1\/api\/element_sets\/1","name":"Dublin Core","resource":"element_sets"},"element":{"id":50,"url":"http:\/\/localhost\/omeka-2.1-rc1\/api\/elements\/50","name":"Title","resource":"elements"}}]}'
    client.post("items", body).code.must_equal 201
    id = client.omeka_items.last.id

    # We can't make an assertion yet, because of a bug in the rest gem.
    client.delete("items", id)
  end

end
