require 'ronin/network/http'

require 'nokogiri'

ronin_extension do

  def check(*urls,&block)
    valid_urls = []

    each_filename do |filename|
      urls.each do |url|
        new_url = URI(url.to_s)
        new_url.path = File.join(new_url.path,filename)

        if Net.http_ok?(:url => new_url)
          block.call(new_url) if block
          valid_urls << new_url
        end
      end
    end

    return valid_urls
  end

  def each_filename(&block)
    path = File.join(File.dirname(__FILE__),'static','word_list.xml')
    doc = Nokogiri::XML(File.open(path))

    doc.search('/word-list/word').each do |word|
      block.call(word.inner_text)
    end

    return nil
  end

end
