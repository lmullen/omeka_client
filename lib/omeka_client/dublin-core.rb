require "recursive_open_struct"

module OmekaClient
  class DublinCore
    
    def method_missing(meth, *args, &block)
      return nil
    end
    
    
    def initialize(data)
      # Step through the element texts separating them into Dublin Core and
      # Item Type Metadata elements. e is the element text hash; i is the
      # index of the element_text in the array of element texts. Then create
      # reader and setter methods that point back to @data in the original
      # class.
      data.element_texts.each_with_index do |e, i|
        if e.element_set.name == "Dublin Core"
          define_singleton_method(
            e.element.name.downcase.gsub(/\s/, '_'),
            proc{ data.element_texts[i].text }
          )
          define_singleton_method(
            e.element.name.downcase.gsub(/\s/, '_').gsub(/$/, '='),
            proc{ |value| data.element_texts[i].text = value }
          )
        end
      end
    end
  end
end
