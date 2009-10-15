module Twitter
  class User

    # Name of the user
    attr_reader :name

    # The URL for the user
    attr_reader :url

    # The recent tweets from the user
    attr_reader :tweets

    #
    # Creates a new User object with the specified _name_.
    #
    def initialize(name)
      @url = "http://twitter.com/#{name}/"
      @tweets = []
    end

    alias to_s name

  end
end
