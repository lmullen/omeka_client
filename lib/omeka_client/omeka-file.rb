require "recursive_open_struct"
require "pry"
module OmekaClient

  #
  # A class to represent an item in an Omeka site
  #
  # @author Lincoln Mullen
  # @since  0.0.2
  #
  class OmekaFile
    attr_accessor :data

    # Parse the data we got from the API into handy methods. All of the data
    # from the JSON returned by the API is available as RecursiveOpenStructs
    # through @data. The Dublin Core and Item Type Metadata fields are also
    # available though special methods of the form dc_title and itm_field.
    #
    # @param  hash [Hash] Uses the parsed hash from JSON api
    #
    def initialize(hash)
      @data = RecursiveOpenStruct.new(hash, :recurse_over_arrays => true)
#      @dublin_core = DublinCore.new(@data)
#      @item_type_metadata = ItemTypeMetadata.new(@data)
    end

    def item
      item_id = @data.item.id
    end


  end

end
