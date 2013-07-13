# require "minitest/spec"
require "minitest/autorun"

test_endpoint = "http://localhost/omeka-2.1-rc1/api"
test_api_key = "c56c8f542bc98483b71896523d4faa6321de193b"

require "omeka_client"

describe OmekaClient::Client do

  it "must have an endpoint" do
    client = OmekaClient::Client.new(test_endpoint)
    client.endpoint.must_equal test_endpoint
  end

  it "can be created without an API key" do
    client = OmekaClient::Client.new(test_endpoint)
    client.api_key.must_be_nil
  end

  it "can be created with an API key" do
    client = OmekaClient::Client.new(test_endpoint, test_api_key)
    client.api_key.must_equal test_api_key
  end

  it "must successfully request items and collections " do
    client = OmekaClient::Client.new(test_endpoint, test_api_key)
    resources = ["items", "collections"]
    resources.each do |resource|
      client.get(resource).code.must_equal 200
    end
  end

  it "must successfully request a single item or collection" do
    client = OmekaClient::Client.new(test_endpoint, test_api_key)
    resources = ["items", "collections"]
    resources.each do |resource|
      client.get(resource, 1).code.must_equal 200
    end
  end

  it "must return a persistent wrapper for a GET request" do
    client = OmekaClient::Client.new(test_endpoint, test_api_key)
    resources = ["items", "collections"]
    resources.each do |resource|
      client.get(resource).must_be_instance_of \
      Rest::Wrappers::NetHttpPersistentResponseWrapper
    end
  end

  it "must return a hash or array for a GET request" do
    client = OmekaClient::Client.new(test_endpoint, test_api_key)
    resources = ["items", "collections"]
    resources.each do |resource|
      client.get_hash(resource).must_be_instance_of Array || Hash
    end
  end

end
