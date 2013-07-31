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
    attr_accessor :data, :dublin_core, :item_type_metadata

    #
    # Parse the data we got from the API into handy methods
    # @param  hash [Hash] Uses the hash from OmekaClient::Client::get_hash
    #
    def initialize(hash)
      @data = RecursiveOpenStruct.new(hash, :recurse_over_arrays => true)

      # @data.new_ostruct_member(:dublin_core)

      dublin_core = Hash.new
      item_type_metadata = Hash.new
      @data.element_texts.each do |element_text|
        if element_text.element_set.name == "Dublin Core"
          method_name = element_text.element.name.downcase.gsub(/\s/, '_')
          value       = element_text.text
          dublin_core[method_name] = value
        elsif element_text.element_set.name == "Item Type Metadata"
          method_name = element_text.element.name.downcase.gsub(/\s/, '_')
          value       = element_text.text
          item_type_metadata[method_name] = value
        end
      end

      @dublin_core = RecursiveOpenStruct.new(dublin_core)
      @item_type_metadata = RecursiveOpenStruct.new(item_type_metadata)

    end

  end

end
