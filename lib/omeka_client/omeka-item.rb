require "ostruct"

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
    # @param  hash [Hash] Uses the hash from OmekaClient::Client::get_hash
    # 
    def initialize(hash)

      # Some of these values have strings. Others return arrays or hashes.
      @id = hash['id']
      @url = hash['url']
      @public = hash['public']
      @featured = hash['featured']
      @added = hash['added']
      @modified = hash['modified']
      @item_type = hash['item_type']
      @collection = hash['collection']
      @owner = hash['owner']
      @files = hash['files']
      @tags = hash['tags']
      @extended_resources = ['extended_resources']

      # OpenStruct.new requires a hash of method names and methods values,
      # which we construct here for Dublin Core and for the Item Type
      # Metadata. The downside is that we are discarding some data.
      # Element names become method names: "Lesson Plan" to "lesson_plan"
      dc_metadata = Hash.new
      item_metadata = Hash.new
      hash['element_texts'].each do |e|
        if e['element_set']['name'] == "Dublin Core"
          method_name = e['element']['name'].downcase.gsub(/\s/, '_')
          dc_metadata[method_name] = e['text']
        elsif e['element_set']['name'] == "Item Type Metadata"
          method_name = e['element']['name'].downcase.gsub(/\s/, '_')
          item_metadata[method_name] = e['text']
        end
      end

      # The OpenStruct will provide methods of the style
      # item.dublin_core.title
      @dublin_core = OpenStruct.new(dc_metadata)
      @item_type_metadata = OpenStruct.new(item_metadata)

    end

  end

end
