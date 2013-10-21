require "recursive_open_struct"

module OmekaClient

  #
  # A class to represent a collection in an Omeka site
  #
  # @author Lincoln Mullen
  # @since  0.0.5
  #
  class OmekaCollection

    attr_accessor :data, :dublin_core

    # Parse the data we got from the API into handy methods.
    #
    # @param  hash [Hash] Uses the parsed hash the API
    #
    def initialize(client, hash)
      @client = client
      @data = RecursiveOpenStruct.new(hash, :recurse_over_arrays => true)
      @dublin_core = DublinCore.new(@data)
    end

    def items
      @client.get_all_items({:collection => @data.id })
    end


  end

end
