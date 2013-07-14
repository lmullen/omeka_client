module OmekaClient


  # 
  # A class to represent an item in an Omeka site
  # 
  # @author Lincoln Mullen
  # @since  0.0.2
  # 
  class OmekaItem

    # Instance variables for each of the main parts of the metadata
    attr_accessor :id, :url, :public, :featured, :added, :modified, \
    :item_type, :collection, :owner, :files, :tags, :dublin_core, \
    :item_type_metadata, :extended_resources


    # 
    # Parse the data we got from the API into handy methods
    # @param  hash [Hash] The hash returned from OmekaClient::Client::get_hash
    # 
    def initialize(hash)

      @id = hash['id']

    end

  end

end
