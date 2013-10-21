require "minitest/autorun"
require "omeka_client"
require "./test/test_credentials"

# Set up an test client
client = OmekaClient::Client.new(TEST_ENDPOINT, TEST_API_KEY)
site = client.get_site

describe OmekaClient::OmekaSite do
  it "should be of class OmekaSite" do
    site.must_be_instance_of OmekaClient::OmekaSite
  end

  it "should have data about the site" do
    site.data.must_be_instance_of OpenStruct
  end

  it "should know the important data about the site" do
   [:omeka_url, :omeka_version, :title, :description, \
    :author, :copyright]. each do |var|
      site.data.send(var).must_be_instance_of String
    end
  end

end
