require "rest"
require "json"
require "omeka_client/version"

class OmekaClient

  attr_accessor :endpoint, :key, :rest

  def initialize(endpoint, key)
    @endpoint = endpoint
    @key = key
    @rest = Rest::Client.new
  end

  def site
    result =  self.rest.get(self.endpoint + "api/site")
    # puts result.class
    JSON.parse(result.body)
  end

end
