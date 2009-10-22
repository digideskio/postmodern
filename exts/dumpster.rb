require 'ronin/network/http'
require 'uri'
require 'yaml'

ronin_extension do

  def dive(*urls,&block)
    valid_urls = []

    urls.each do |url|
      base_url = URI(url.to_s)

      each_filename do |filename|
        new_url = base_url.merge(filename)

        if Net.http_ok?(:url => new_url)
          block.call(new_url) if block
          valid_urls << new_url
        end
      end
    end

    return valid_urls
  end

  def each_filename(&block)
    files = find_static_files('dumpster/files.yaml')
    exts = find_static_files('dumpster/exts.yaml')

    files.each do |file_path|
      YAML.load_file(file_path).each do |file|

        exts.each do |ext_path|
          YAML.load_file(ext_path).each do |ext|
            block.call("#{file}.#{ext}")
          end
        end

      end
    end

    return nil
  end

end
