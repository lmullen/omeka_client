module OmekaClient

  class Client

    attr_accessor :endpoint, :api_key, :connection

    # Sets up a new client to interact with an Omeka site
    # @param  endpoint [String] the URL of the Omeka API endpoint, without a
    #   trailing slash. For example: "{http://localhost/omeka/api}"
    # @param  api_key [String] The API key of the Omeka user. This can
    #   be null for GET requests,  but  is required for POST, PUT, and DELETE
    #   requests.
    # @return [OmekaClient] The attribute @connection is the client itself,
    #   which is an instance from the Rest gem. This client can be used to
    #   perform arbitrary REST queries. See https://github.com/iron-io/rest
    def initialize(endpoint, api_key = nil )
      @endpoint = endpoint
      @api_key = api_key
      @connection = Rest::Client.new
    end

    # Generic methods
    # -------------------------------------------------------------------

    # Generic GET request to the Omeka site
    # @param  resource [String] The Omeka resource to request, e.g.
    #   "items", "collections"
    # @param  id [Integer] The id of the specific resource to request. Include
    #   an id to get just one item; do not include it to get all the items.
    # @param  query [Hash] Additional query parameters
    # 
    # @return [NetHttpPersistentResponseWrapper] A wrapper around the object
    def get(resource, id = nil, query = {} )
      url = self.endpoint + "/" + resource
      url += "/" + id.to_s unless id.nil?
      query[:key] = self.api_key unless self.api_key.nil?
      self.connection.get(url, :params => query)
    end

    # Parse a GET request into a useable format
    # @param  resource [String] The Omeka resource to request, e.g.
    #   "items", "collections"
    # @param  id [Integer] The id of the specific resource to request. Include
    #   an id to get just one item; do not include it to get all the items.
    # @param  query [Hash] Additional query parameters
    #
    # @return [Array or Hash] A hash of the representation of the object,
    #   or an array of hashes.
    def get_hash(resource, id = nil, query = {} )
      response = self.get(resource, id, query)
      if response.code == 200
        JSON.parse(response.body)
      end
    end

    # Other generic methods to write
    # TODO: post
    # TODO: put
    # TODO: delete

    # Convenience methods
    # -------------------------------------------------------------------

    # 
    # Get the description of the Omeka site
    # 
    # @return [Hash] A hash of the description of the Omeka site
    def site
      self.get_hash('site')
    end

  end

end
