require "minitest/autorun"
require "omeka_client"

# Set up an test client
test_endpoint = "http://localhost/omeka-2.1-rc1/api"
test_api_key  = "3b036221e180af46bafa4b5e4a1db30e84e78e89"    # contributor
client = OmekaClient::Client.new(test_endpoint, test_api_key)
item_a = client.get_item(1)
item_b = client.get_item(2)

describe OmekaClient::DublinCore do
  it "must use singleton methods so that items maintain their own data" do
    item_a.dublin_core.title.wont_equal item_b.dublin_core.title
  end
end
