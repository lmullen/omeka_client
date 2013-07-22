require "minitest/autorun"
require "omeka_client"

# Set up an test client
test_endpoint = "http://localhost/omeka-2.1-rc1/api"
test_api_key = "c56c8f542bc98483b71896523d4faa6321de193b"
client = OmekaClient::Client.new(test_endpoint, test_api_key)
# item_array = client.omeka_items
item_single = client.omeka_items(1)


describe OmekaClient::OmekaItem do

  it "should have an ID" do
    item_single.id.must_equal 1
  end

  it "should have a URL" do
    item_single.url.must_be_instance_of String
  end

  it "should have a URL" do
    item_single.url.must_be_instance_of String
  end

  it "should know whether it's public" do
    item_single.public.wont_be_nil
  end

  it "should know whether it's featured" do
    item_single.featured.wont_be_nil
  end

  it "should have a date added" do
    item_single.added.must_be_instance_of String
  end

  it "should have a date modified" do
    item_single.modified.must_be_instance_of String
  end

  it "should have an item type" do
    item_single.item_type.must_be_instance_of Hash
  end

  it "should have a collection" do
    item_single.collection.must_be_instance_of Hash
  end

  it "should have files" do
    item_single.files.must_be_instance_of Hash
  end

  it "should have tags" do
    item_single.tags.must_be_instance_of Array
  end

  it "should have extended resources" do
    item_single.extended_resources.must_be_instance_of Array
  end

  it "should have the Dublin Core metadata" do
    item_single.dublin_core.must_be_instance_of OpenStruct
    dc_fields = [:title, :subject, :contributor, :description, :creator, \
    :source, :publisher,  :date,  :rights, :relation, :format, :language, \
    :type, :identifier, :coverage]
    dc_fields.each do |field|
      item_single.dublin_core.send(field).must_be_instance_of String
    end
  end

  it "should have the Item Type metadata" do
    item_single.item_type_metadata.must_be_instance_of OpenStruct
    # The item type is unpredictable, so it's hard to be more specific
  end

end
