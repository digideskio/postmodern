require 'milw0rm/page'

module Milw0rm
  class Section

    # Name of the section
    attr_reader :name

    #
    # Creates a new Section object with the specified section _name_.
    #
    def initialize(name)
      @name = name
      @page_cache = Hash.new do |hash,key|
        hash[key] = Page.new(
          "http://milw0rm.com/#{@name}.php",
          key.to_i
        )
      end
    end

    #
    # Returns the page at the specified _index_.
    #
    def page(index)
      @page_cache[index]
    end

    #
    # Returns the first page.
    #
    def first_page
      page(0)
    end

    #
    # Updates all the pages within the section.
    #
    def update!
      @page_cache.each_value { |page| page.update! }
      return self
    end

    alias to_s name

    def inspect # :nodoc:
      "#<#{self.class.name}:#{@name}>"
    end

  end
end
