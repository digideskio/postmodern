require 'ronin/network/http'

module Twitter
  class UserCache

    #
    # Creates a new empty UserCache object.
    #
    def initialize
      @users = Hash.new do |hash,name|
        if Net.http_ok?(:url => "http://twitter.com/#{name}")
          hash[name] = User.new(name)
        end
      end
    end

    alias has? has_key?
    alias each_name each_key
    alias each_user each_value

  end
end
