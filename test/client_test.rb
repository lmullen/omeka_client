require "minitest/autorun"
require "omeka_client"
require "./test/test_credentials"

describe OmekaClient::Client do

  # Setup a test client
  resources     = ["items", "collections"]
  client        = OmekaClient::Client.new(TEST_ENDPOINT, TEST_API_KEY)

  it "must have an endpoint" do
    client.endpoint.must_equal TEST_ENDPOINT
  end

  it "can be created without an API key" do
    keyless = OmekaClient::Client.new(TEST_ENDPOINT)
    keyless.api_key.must_be_nil
  end

  it "can be created with an API key" do
    client.api_key.must_equal TEST_API_KEY
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

  # it "must return a representation of the site description" do
  #   client.site['title'].wont_be_nil
  # end

  # it "must list the resources available via the API" do
  #   client.resources.must_be_instance_of Hash
  #   client.resources.wont_be_empty
  # end

  it "must list the items available via the API" do
    client.get_all_items.must_be_instance_of Array
    client.get_all_items.wont_be_empty
  end

  it "must list the collections available via the API" do
    client.get_all_collections.must_be_instance_of Array
    client.get_all_collections.wont_be_empty
  end

  it "must return an OmekaItem class" do
   client.get_item(1).must_be_instance_of OmekaClient::OmekaItem
 end

  # it "must return an array of OmekaItem classes" do
  #   client.get_all_items.must_be_instance_of Array
  #   [0,1].each do |number|
  #     client.get_item[number].must_be_instance_of \
  #     OmekaClient::OmekaItem
  #   end
  # end

  it "must be able to POST an item and then DELETE it" do
    body = '{"public":true,"featured":false,"element_texts":[{"html":false,"text":"Item Added via API","element_set":{"id":1,"url":"http:\/\/localhost\/omeka-2.1-rc1\/api\/element_sets\/1","name":"Dublin Core","resource":"element_sets"},"element":{"id":50,"url":"http:\/\/localhost\/omeka-2.1-rc1\/api\/elements\/50","name":"Title","resource":"elements"}}]}'
    client.post("items", body).code.must_equal 201
    id = client.get_all_items.last.data.id

    # We can't make an assertion yet, because of a bug in the rest gem.
    client.delete("items", id)
  end

  # it "must be able to update an item via PUT" do
  #   body_original = '{"public":true,"featured":false,"element_texts":[{"html":false,"text":"Item Added via API","element_set":{"id":1,"url":"http:\/\/localhost\/omeka-2.1-rc1\/api\/element_sets\/1","name":"Dublin Core","resource":"element_sets"},"element":{"id":50,"url":"http:\/\/localhost\/omeka-2.1-rc1\/api\/elements\/50","name":"Title","resource":"elements"}}]}'
  #   body_updated = '{"featured":true,"element_texts":[{"html":false,"text":"Item Updated via API","element_set":{"id":1,"url":"http:\/\/localhost\/omeka-2.1-rc1\/api\/element_sets\/1","name":"Dublin Core","resource":"element_sets"},"element":{"id":50,"url":"http:\/\/localhost\/omeka-2.1-rc1\/api\/elements\/50","name":"Title","resource":"elements"}}]}'
  #   client.post("items", body_original)
  #   item_original = client.get_all_items.last
  #   item_original.dublin_core.title.must_equal "Item Added via API"
  #   item_original.data.featured.must_equal false
  #   client.put("items", item_original.data.id, body_updated).code.must_equal 200
  #   item_updated = client.get_all_items(item_original.data.id)
  #   item_updated.dublin_core.title.must_equal "Item Updated via API"
  #   item_updated.data.featured.must_equal true
  # end

  # it "must be able to post, put, and delete an OmekaItem" do
  #   item = client.get_item(1)
  #   item.dublin_core.title = "This item has been added via the API"
  #   client.post_items(item).code.must_equal 201
  #   new_item = client.get_all_items.last
  #   new_item.dublin_core.title.must_equal item.dublin_core.title
  #   new_item.dublin_core.title = "This item has been updated via the API"
  #   client.put_items(new_item).code.must_equal 200
  #   client.delete_item(new_item) # can't test response code because of the bug
  # end

end
