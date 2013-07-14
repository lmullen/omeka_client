require "minitest/autorun"
require "omeka_client"

# Set up an test client
test_endpoint = "http://localhost/omeka-2.1-rc1/api"
test_api_key = "c56c8f542bc98483b71896523d4faa6321de193b"
resources = ["items", "collections"]
client = OmekaClient::Client.new(test_endpoint, test_api_key)
# item_array = client.omeka_items
item_single = client.omeka_items(1)


describe OmekaClient::OmekaItem do

  it "should have an id" do
    item_single.id.must_equal 1
  end

end
