require 'ronin/scanners/url_scanner'
require 'ronin/network/mixins/http'

Ronin::Scanners::URLScanner.object do

  extend Network::Mixins::HTTP

  cache do
    self.name = 'Oracle Application Server Detection'
    self.version = '0.1'
    self.description = %{
      This scans for common ORACLE Database Access Desriptors (DAD)
    }

    author :name => 'CG', :organization => 'carnal0wnage'
    license! :mit
  end

  def scan
    http_session do |http|
      paths = YAML.load_file(find_data_file('oracle/dad_fingerprints.yml'))

      paths.each do |path|
        response = begin
                     http.get(path)
                   rescue Exception
                     print_error "HTTP Request failed for #{path}"
                     next
                   end

        case response.code
        when '200'
          print_info "HTTP 200 for DAD: #{path}"

          yield "http://#{@host}:#{@port}#{path}"
        when '302', '301'
          location = response.headers['Location']

          print_info "HTTP #{response.code} for DAD: #{path} -> #{location}"
        else
          print_debug "HTTP #{response.code} for #{path}"
        end
      end
    end
  end

end
