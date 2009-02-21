require 'milw0rm/exploits'

module Milw0rm
  class Page < Array

    # Default number of exploits per page
    PER_PAGE = 30

    # URL to the page
    attr_reader :url

    #
    # Creates a new Page object with the specified _url_ and page _index_.
    #
    def initialize(url,index)
      super()

      @url = URI(url)
      @url.query_params['start'] = ((index - 1) * PER_PAGE)

      update!
    end

    def titles
      map { |exploit| exploit.title }
    end

    def each_title(&block)
      each { |exploit| block.call(exploit.title) }
    end

    def urls
      map { |exploit| exploit.url }
    end

    def each_url(&block)
      each { |exploit| block.call(exploit.url) }
    end

    #
    # Returns an Array of the unique authors on the page.
    #
    def authors
      map { |exploit| exploit.author }.uniq
    end

    #
    # Iterates over every unique author on the page, passing each to the
    # specified _block_.
    #
    def each_author(&block)
      authors.each(&block)
    end

    #
    # Updates the exploits on the page.
    #
    def update!
      clear

      Web.get(@url).search('tr.submit').each do |row|
        title = row.at('td[0]').inner_text
        link = row.at('td[1]/a')
        author = row.at('td[7')

        self << Exploit.new(
          title.inner_text,
          link.inner_text,
          url.merge(link.get_attribute('href')),
          author.inner_text
        )
      end
    end

  end
end
