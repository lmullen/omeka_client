module OmekaClient

  class Client

    attr_accessor :endpoint, :api_key, :connection

    def initialize(endpoint, api_key = nil )
      @endpoint = endpoint
      @api_key = api_key
      @connection = Rest::Client.new
    end

    def get(resource, id = nil, query = {} )
      url = self.endpoint + "/" + resource
      url += "/" + id.to_s unless id.nil?
      self.connection.get(url)
    end

    def site
      result =  self.rest.get(self.endpoint + "api/site")
      JSON.parse(result.body)
    end


  end

end
