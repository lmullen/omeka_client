require "minitest/autorun"
require "omeka_client"
require "./test/test_credentials"


# Set up an test client
client = OmekaClient::Client.new(TEST_ENDPOINT, TEST_API_KEY)
collection = client.get_collection(1)

describe OmekaClient::OmekaCollection do
  it "should be of class OmekaCollection" do
    collection.must_be_instance_of OmekaClient::OmekaCollection
  end

  it "should represent the JSON data as a RecursiveOpenStruct" do
    collection.data.must_be_instance_of RecursiveOpenStruct
  end

  it "should have an ID" do
    collection.data.id.must_equal 1
  end

  it "should have a URL" do
    collection.data.url.must_be_instance_of String
  end

  it "should know whether it's public" do
    collection.data.public.wont_be_nil
  end

  it "should know whether it's featured" do
    collection.data.featured.wont_be_nil
  end

  it "should have a date added" do
    collection.data.added.must_be_instance_of String
  end

  it "should have a date modified" do
    collection.data.modified.must_be_instance_of String
  end

  it "should know how many items it has" do
    collection.data.items.count.must_be_instance_of Fixnum
  end

  it "should have an items helper" do
    collection.items.first.must_be_instance_of OmekaClient::OmekaItem
  end



  it "should have extended resources" do
    collection.data.extended_resources.must_be_instance_of Array
  end

  it "should have methods for each of the Dublin Core metadata" do
    fields = [:title, :subject, :contributor, :description, :creator, \
    :source, :publisher,  :date,  :rights, :relation, :format, :language, \
    :type, :identifier, :coverage]
    fields.each do |field|
      collection.dublin_core.send(field).must_be_instance_of String
    end
  end

end
