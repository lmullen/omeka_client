module OmekaClient

  # A class to create clients that interact with the Omeka API
  #
  # @author Lincoln Mullen
  #
  class Client

    attr_accessor :endpoint, :api_key, :connection

    # Sets up a new client to interact with an Omeka site
    #
    # @param  endpoint [String] the URL of the Omeka API endpoint, without a
    #   trailing slash. For example: "{http://localhost/omeka/api}"
    # @param  api_key [String] The API key of the Omeka user. This can
    #   be null for GET requests,  but  is required for POST, PUT, and DELETE
    #   requests.
    # 
    # @return [OmekaClient] The attribute @connection is the client itself,
    #   which is an instance from the Rest gem. This client can be used to
    #   perform arbitrary REST queries. See https://github.com/iron-io/rest
    #
    # @since 0.0.1
    def initialize(endpoint, api_key = nil )
      @endpoint = endpoint
      @api_key = api_key
      @connection = Rest::Client.new
    end

    # Generic GET request to the Omeka site
    # @param  resource [String] The Omeka resource to request, e.g.
    #   "items", "collections"
    # @param  id [Integer] The id of the specific resource to request. Include
    #   an id to get just one item; do not include it to get all the items.
    # @param  query [Hash] Additional query parameters
    #
    # @return [NetHttpPersistentResponseWrapper] A wrapper around the object
    # @since 0.0.1
    def get(resource, id = nil, query = {} )
      build_request("get", resource, id, nil, query)
    end

    # Generic POST request to the Omeka site
    # @param  resource [String] The Omeka resource to request, e.g.
    #   "items", "collections"
    # @param  body [String] A string containing a JSON representation of the body of the item
    # @param  query = {} [Hash] Additional query parameters (optional)
    #
    # @return [NetHttpPersistentResponseWrapper] A wrapper around the object
    # @since 0.0.3
    def post(resource, body = nil, query = {} )
      build_request("post", resource, nil, body, query)
    end

    # Generic DELETE request to the Omeka site
    # @param  resource [String] The type of Omeka resource to delete, e.g.
    #   "items", "collections"
    # @param  id [Integer] The id number of the Omeka resource to delete
    #
    # @return [NetHttpPersistentResponseWrapper] A wrapper around the object
    # @since 0.0.3
    def delete(resource, id)
      build_request("delete", resource, id, nil, {})
    end

    # Generic PUT request to the Omeka site
    # @param  resource [String] The type of Omeka resource to update, e.g.
    #   "items", "collections"
    # @param  id [Integer] The id number of the Omeka resource to update
    # @param  query = {} [Hash] Additional query parameters
    #
    # @return [NetHttpPersistentResponseWrapper] A wrapper around the object
    # @since 0.0.3
    def put(resource, id, body, query = {} )
      build_request("put", resource, id, body, query)
    end

    # Get single Omeka item represented as an OmekaItem class
    # @param  id  [Integer] The ID of the item to return. 
    # @param  query = {} [Hash] Additional query parameters
    # @since  1.0.0
    #
    # @return [OmekaItem] An OmekaItem representation of the desired item
    def get_item(id, query = {} )
      response = self.get('items', id, query).body
      return OmekaClient::OmekaItem.new(self, JSON.parse(response))
    end

    # Get all the items represented as an array of OmekaItems
    # @param query = {} [Hash] Additional query parameters
    # @since 1.0.0
    #
    # @return [Array] An array of OmekaItems
    def get_all_items(query = {})
      response = self.get('items', nil, query).body
      parsed = JSON.parse(response)
      all_items = []
      parsed.each do |item_hash|
        all_items.push OmekaClient::OmekaItem.new(self, item_hash)
      end
      return all_items
    end

    # Get a OmekaCollection class representation of an Omeka collection
    # @param  id  [Integer] The ID of the collection to return. No value gets
    # an array of all the items.
    # @return  [OmekaCollection] An OmekaCollection object
    # @since 1.0.0
    def get_collection(id)
      response = self.get('collections', id).body
      return OmekaClient::OmekaCollection.new(self, JSON.parse(response))
    end

    # Get a OmekaCollection class representation of an Omeka collection
    # @param  id  [Integer] The ID of the collection to return. No value gets
    # an array of all the items.
    # @return  [Array] An OmekaCollection object
    # @since 1.0.0
    def get_all_collections()
      response = self.get('collections').body
      parsed = JSON.parse(response)
      all_collections = []
      parsed.each do |item_hash|
        all_collections.push OmekaClient::OmekaCollection.new(self, item_hash)
      end
      return all_collections
    end

    # Get single Omeka item represented as an OmekaItem class
    # @param  id  [Integer] The ID of the item to return. 
    # @param  query = {} [Hash] Additional query parameters
    # @since  X.X.X
    #
    # @return [OmekaFile] An OmekaFile representation of the desired file
    def get_file(id, query = {} )
      response = self.get('files', id, query).body
      return OmekaClient::OmekaFile.new(self, JSON.parse(response))
    end


    # Get all the files represented as an array of OmekaFiles
    # @param query = {} [Hash] Additional query parameters
    # @since 1.0.0
    #
    # @return [Array] An array of OmekaItems
    def get_all_files(query = {})
      response = self.get('files', nil, query).body
      
      parsed = JSON.parse(response)
      all_files = []
      parsed.each do |file_hash|
        all_files.push OmekaClient::OmekaFile.new(self, file_hash)
      end
      return all_files
    end

    # Create a new item from an OmekaItem instance
    # @param omeka_item [OmekaItem] An instance of OmekaItem
    # @since 0.0.4
    def post_item(omeka_item)
      self.post("items", omeka_item.data.to_h.to_json)
    end

    # Update an item using an OmekaItem instance
    # @param omeka_item [OmekaItem] An instance of OmekaItem
    # @since 0.0.4
    def put_item(omeka_item)
      self.put("items", omeka_item.data.id, omeka_item.data.to_h.to_json)
    end

    # Delete the item represented by an OmekaItem instance
    # @param omeka_item [OmekaItem] An instance of OmekaItem
    # @since 0.0.4
    def delete_item(omeka_item)
      self.delete("items", omeka_item.data.id)
    end

    # Get a OmekaSite class representation of the Omeka site
    # @return [OmekaSite] The representation of the Omeka site
    # @since 0.0.5
    def get_site
      response = self.get('site').body
      OmekaSite.new(JSON.parse(response))
    end


    # Helper method to build an API request
    #
    # @param method [String] The type of REST request to make: "get", "post", 
    #   "put", or "delete".
    # @param resource [String] The type of resource to request from the Omeka 
    #   site, e.g., "items" or "site".
    # @param id [Integer] The id of the resource to request from the Omeka 
    #   site.
    # @param body [] The body of a request in a PUT or POST request.
    # @param query [Hash] Additional query parameters for the request.
    #
    # @return [NetHttpPersistentResponseWrapper] A wrapper around the API's 
    # response, containing the HTTP code and the response body.
    # 
    # @since 1.0.0
    #
    def build_request(method, resource = nil, id = nil, body =nil, query = {})

      url =  self.endpoint 
      url += "/" + resource unless resource.nil?
      url += "/" + id.to_s unless id.nil?
      query[:key] = self.api_key unless self.api_key.nil?

      case method
      when "get"
        self.connection.get(url, :params => query)
      when "post"
        self.connection.post(url, :body => body, :params => query)
      when "put"
        self.connection.put(url, :body => body, :params => query)
      when "delete"
        begin
          self.connection.delete(url, :params => query)
        rescue TypeError
          # Not putting the error to stdout
        end
      end

    end
    private :build_request

  end

end
