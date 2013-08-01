require "minitest/autorun"
require "omeka_client"

# Set up an test client
test_endpoint = "http://localhost/omeka-2.1-rc1/api"
test_api_key  = "3b036221e180af46bafa4b5e4a1db30e84e78e89"    # contributor
client = OmekaClient::Client.new(test_endpoint, test_api_key)
item = client.omeka_items(1)

describe OmekaClient::OmekaItem do

  it "should represent the JSON data as a RecursiveOpenStruct" do
    item.data.must_be_instance_of RecursiveOpenStruct
  end

  it "should have an ID" do
    item.data.id.must_equal 1
  end

  it "should have a URL" do
    item.data.url.must_be_instance_of String
  end

  it "should know whether it's public" do
    item.data.public.wont_be_nil
  end

  it "should know whether it's featured" do
    item.data.featured.wont_be_nil
  end

  it "should have a date added" do
    item.data.added.must_be_instance_of String
  end

  it "should have a date modified" do
    item.data.modified.must_be_instance_of String
  end

  it "should have an item type" do
    item.data.item_type.must_be_instance_of RecursiveOpenStruct
  end

  it "should have a collection" do
    item.data.collection.must_be_instance_of RecursiveOpenStruct
  end

  it "should have files" do
    item.data.files.must_be_instance_of RecursiveOpenStruct
  end

  it "should have tags" do
    item.data.tags.must_be_instance_of Array
  end

  it "should have extended resources" do
    item.data.extended_resources.must_be_instance_of Array
  end

  it "should have methods for each of the Dublin Core metadata" do
    dc_fields = [:title, :subject, :contributor, :description, :creator, \
    :source, :publisher,  :date,  :rights, :relation, :format, :language, \
    :type, :identifier, :coverage]
    dc_fields.each do |field|
      item.send("dc_#{field}").must_be_instance_of String
    end
  end

  it "should have the Item Type metadata" do
    # We're assuming we know the item type, in this case Lesson Plan
    itm_fields = [:duration, :standards, :objectives, :materials, \
      :lesson_plan_text]
    itm_fields.each do |field|
      item.send("itm_#{field}").must_be_instance_of String
    end
  end

  it "should be able to set the Dublin Core values and access them" do
    new_title = "My New DC Title"
    item.dc_title = new_title
    item.data.element_texts[0].text.must_equal new_title
  end

end
