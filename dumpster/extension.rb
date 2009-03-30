require 'ronin/network/http'

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
    files = find_static_files('files.yaml')
    exts = find_static_files('exts.yaml')

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
