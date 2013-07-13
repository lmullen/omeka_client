# require "minitest/spec"
require "minitest/autorun"

test_site_url = "http://localhost/omeka-2.1-rc1"

require "omeka_client"

describe OmekaClient::Client do

  it "must generate an endpoint from a site url" do
    OmekaClient::Client.new(test_site_url).endpoint.must_equal \
    "http://localhost/omeka-2.1-rc1/api"
  end

  it "can be created without an API key" do
    OmekaClient::Client.new(test_site_url).api_key.must_be_nil
  end

end
