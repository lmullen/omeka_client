require "minitest/autorun"
require "omeka_client"
require "./test/test_credentials"


# Set up an test client
client = OmekaClient::Client.new(TEST_ENDPOINT, TEST_API_KEY)
item = client.get_item(1)

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
    fields = [:title, :subject, :contributor, :description, :creator, \
    :source, :publisher,  :date,  :rights, :relation, :format, :language, \
    :type, :identifier, :coverage]
    fields.each do |field|
      item.dublin_core.send(field).must_be_instance_of String
    end
  end

  it "should have the Item Type metadata" do
    # We're assuming we know the item type, in this case Lesson Plan
    fields = [:duration, :standards, :objectives, :materials, \
      :lesson_plan_text]
    fields.each do |field|
      item.item_type_metadata.send(field).must_be_instance_of String
    end
  end

  it "should have a collection helper method" do
    item.collection.must_be_instance_of OmekaClient::OmekaCollection
  end

  # it "should be able to set the Dublin Core values and access them" do
  #   item = client.omeka_items(1)
  #   item.dublin_core.title = "This Is the New Title"
  #   item.data.element_texts[0].text.must_equal item.dublin_core.title
  # end

end
