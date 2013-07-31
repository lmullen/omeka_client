require "recursive-open-struct"

module OmekaClient

  #
  # A class to represent an item in an Omeka site
  #
  # @author Lincoln Mullen
  # @since  0.0.2
  #
  class OmekaItem

    # Instance variables for each of the main parts of the metadata
    attr_accessor :data

    #
    # Parse the data we got from the API into handy methods
    # @param  hash [Hash] Uses the hash from OmekaClient::Client::get_hash
    #
    def initialize(hash)
      @data = RecursiveOpenStruct.new(hash)
    end

  end

end
