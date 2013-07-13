# require "minitest/spec"
require "minitest/autorun"

test_endpoint = "http://localhost/omeka-2.1-rc1/api"

require "omeka_client"

describe OmekaClient::Client do

  it "must have an endpoint" do
    OmekaClient::Client.new(test_endpoint).endpoint.must_equal \
    "http://localhost/omeka-2.1-rc1/api"
  end

  it "can be created without an API key" do
    OmekaClient::Client.new(test_endpoint).api_key.must_be_nil
  end

  it "must successfully request items and collections " do
    client = OmekaClient::Client.new(test_endpoint)
    resources = ["items", "collections"]
    resources.each do |resource|
      client.get(resource).code.must_equal 200
    end
  end

  it "must successfully request a single item or collection" do
    client = OmekaClient::Client.new(test_endpoint)
    resources = ["items", "collections"]
    resources.each do |resource|
      client.get(resource, 1).code.must_equal 200
    end
  end

end
