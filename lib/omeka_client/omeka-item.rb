require "recursive-open-struct"

module OmekaClient

  #
  # A class to represent an item in an Omeka site
  #
  # @author Lincoln Mullen
  # @since  0.0.2
  #
  class OmekaItem

    attr_accessor :data

    # Parse the data we got from the API into handy methods. All of the data
    # from the JSON returned by the API is available as RecursiveOpenStructs
    # through @data. The Dublin Core and Item Type Metadata fields are also
    # available though special methods of the form dc_title and itm_field.
    #
    # @param  hash [Hash] Uses the hash from OmekaClient::Client::get_hash
    #
    def initialize(hash)
      @data = RecursiveOpenStruct.new(hash, :recurse_over_arrays => true)

      # Step through the element texts separating them into Dublin Core and
      # Item Type Metadata elements. e is the element text hash; i is the
      # index of the element_text in the array of element texts.
      @data.element_texts.each_with_index do |e, i|
        if e.element_set.name == "Dublin Core"
          # Define a reader method that retrieves the data from this element
          # text in @data
          self.class.send(:define_method,
            # The name of the method will have the form "dc_title"
            e.element.name.downcase.gsub(/^/, 'dc_').gsub(/\s/, '_'),
            proc{ @data.element_texts[i].text }
            )
          # Define a setter method that sets the data for this element text in
          # @ data
          self.class.send(:define_method,
            # The name of the method will have the form "dc_title="
            e.element.name.downcase.gsub(/^/, 'dc_').gsub(/\s/, '_').gsub(/$/, '='),
            proc{ |value| @data.element_texts[i].text = value }
            )
        elsif e.element_set.name == "Item Type Metadata"
          # Define a reader method that retrieves the data from this element
          # text in @data
          self.class.send(:define_method,
            # The name of the method will have the form "itm_field"
            e.element.name.downcase.gsub(/^/, 'itm_').gsub(/\s/, '_'),
            proc{ @data.element_texts[i].text }
            )
          # Define a setter method that sets the data for this element text in
          # @ data
          self.class.send(:define_method,
            # The name of the method will have the form "itm_title="
            e.element.name.downcase.gsub(/^/, 'itm_').gsub(/\s/, '_').gsub(/$/, '='),
            proc{ |value| @data.element_texts[i].text = value }
            )
        end
      end

    end

  end

end
