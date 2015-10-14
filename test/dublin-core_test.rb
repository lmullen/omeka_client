require "minitest/autorun"
require "omeka_client"
require "./test/test_credentials"

# Set up an test client
client = OmekaClient::Client.new(TEST_ENDPOINT, TEST_API_KEY)
item_a = client.get_item(1)
item_b = client.get_item(2)

describe OmekaClient::DublinCore do
  it "must use singleton methods so that items maintain their own data" do
    item_a.dublin_core.title.wont_equal item_b.dublin_core.title
  end
end
