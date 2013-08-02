require "minitest/autorun"
require "omeka_client"

# Set up an test client
test_endpoint = "http://localhost/omeka-2.1-rc1/api"
test_api_key  = "3b036221e180af46bafa4b5e4a1db30e84e78e89"    # contributor
client = OmekaClient::Client.new(test_endpoint, test_api_key)
site = client.get_site

describe OmekaClient::OmekaSite do
  it "should be of class OmekaSite" do
    site.must_be_instance_of OmekaSite
  end

  it "should have data about the site" do
    site.data.must_be_instance_of OpenStruct
  end

  it "should know the important data about the site" do
   [:omeka_url, :omeka_version, :title, :description, \
    :author, :copyright]. each do |var|
      site.send(var).must_be_instance_of String
    end
  end

end
