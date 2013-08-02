require "ostruct"

module OmekaClient

  #
  # A class to represent an Omeka site
  #
  # @author Lincoln Mullen
  # @since  0.0.5
  #
  class OmekaSite

    # @data holds the site information such as URL and title
    attr_accessor :data

    def initialize(hash)
      @data = OpenStruct.new(hash)
    end

  end

end
