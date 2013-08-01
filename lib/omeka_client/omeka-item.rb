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
      @data = RecursiveOpenStruct.new(hash, :recurse_over_arrays => true)

      @data.element_texts.each_with_index do |element_text, index|
        if element_text.element_set.name == "Dublin Core"
          self.class.send(:define_method,
            element_text.element.name.downcase.gsub(/^/, 'dc_').gsub(/\s/, '_'),
            proc{@data.element_texts_as_a_hash[index]["text"]}
            )
          self.class.send(:define_method,
            element_text.element.name.downcase.gsub(/^/, 'dc_').gsub(/\s/, '_').gsub(/$/, '='),
            proc{ |value| @data.element_texts[index].text = value }
            )
        end
      end

    end

  end

end
