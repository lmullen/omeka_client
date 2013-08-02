require "ostruct"

module OmekaClient

  #
  # A class to represent an Omeka site
  #
  # @author Lincoln Mullen
  # @since  0.0.5
  #
  class OmekaSite

    # Site information such as URL and title stored in @data
    attr_accessor :data

    def initialize(hash)
      @data = OpenStruct.new(hash)
    end

  end

end
