require 'ronin/scanners/vuln_scanner'

Ronin::Scanners::VulnScanner.object do

  parameter :host, :description => 'The host to check'
  parameter :port, :default => 80,
                   :description => 'The port to check'

  cache do
    self.name = 'Oracle Application Server Check'
    self.version = '0.1'
    self.description = %{
      This module scans for common files on an Oracle Application Server
      and Oracle Database Server.  If you are having issues. Enable verbose
      output to see all error codes.
    }

    self.author(:name => 'MC')
    self.author(:name => 'CG', :organization => 'carnal0wnage')
    self.license!(:mit)
  end

  def scan
    Net.http_session(:host => @host, :port => @port) do |http|
      checks = YAML.load_file(find_data_file('oracle/oas_fingerprints.yml'))

      checks.each do |check|
        path = check[:path]

        methopd = check.fetch(:method,'GET')
        response = begin
                     case method
                     when 'POST'
                       http.post(path)
                     else
                       http.get(path)
                     end
                   rescue Exception
                     print_error "HTTP Request failed for #{path}"
                     next
                   end

        case response.code
        when 200
          print_info "Found: #{path} Vuln: #{check[:vuln]}"

          yield Vulns::Web.new(
            :request_method => method.to_s.upcase,
            :url => URL.parse("http://#{@host}:#{@port}#{path}")
          )
        when 401
          print_info "HTTP 401: #{path} Vuln: #{check[:vuln]}"
        when 302, 301
          location = response.headers['Location']

          print_info "HTTP Redirect: #{path} -> #{location}"
        else
          print_debug "Received #{response.code} for #{path}"
        end
      end
    end
  end

end
