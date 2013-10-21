require "minitest/autorun"
require "omeka_client"
require "./test/test_credentials"


# Set up an test client
client = OmekaClient::Client.new(TEST_ENDPOINT, TEST_API_KEY)

# item should have at least two files associated with it
item = client.get_item(1)

file = client.get_file(1)

describe OmekaClient::OmekaFile do

  it "should represent the JSON data as a RecursiveOpenStruct" do
    file.data.must_be_instance_of RecursiveOpenStruct
  end

  it "should have an ID" do
    file.data.id.must_equal 1
  end

  it "should have a URL" do
    file.data.url.must_be_instance_of String
  end


  # it "should have an item helper" do
    # file.item.must_be_instance_of OmekaClient::OmekaItem
  # end


end
