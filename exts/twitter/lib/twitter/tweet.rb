require 'set'

module Twitter
  class Tweet

    # The user who sent the tweet
    attr_accessor :user

    # The twitter id of the tweet
    attr_accessor :twitter_id

    # Body of the tweet
    attr_reader :body

    # Specifies wether the tweet was a retweet
    attr_accessor :retweet

    # URLs mentioned in the tweet
    attr_reader :urls

    # Tags used in the tweet
    attr_reader :tags

    # Date and Time the tweet was sent
    attr_accessor :date

    # Software the tweet was sent from
    attr_accessor :from

    # The tweet that this tweet is replying to
    attr_accessor :reply_to

    #
    # Creates a new Tweet object with the specified _body_.
    #
    def initialize(body)
      @user = nil
      @twitter_id = nil

      @body = body.to_s

      @retweet = false
      @urls = []
      @tags = Set[]

      @date = nil
      @from = nil
      @reply_to = nil
    end

    #
    # Returns +true+ if the tweet was a retweet, returns +false+ otherwise.
    #
    def retweet?
      @retweet == true
    end

    #
    # Returns +true+ if the tweet links to the specified _url_, returns
    # +false+ otherwise.
    #
    def links_to?(url)
      @urls.include?(url.to_s)
    end

    #
    # Returns +true+ if the tweet has the specified _tag_, returns +false+
    # otherwise.
    #
    def tagged?(tag)
      @tags.include?(tag.to_s)
    end

    #
    # Returns +true+ if the tweet was sent from the specified _software_,
    # returns +false+ otherwise.
    #
    def from?(software)
      @from == software
    end

    #
    # Returns +true+ if the tweet is a reply to another tweet, returns
    # +false+ otherwise.
    #
    def reply?
      !(@reply_to.nil?)
    end

    #
    # Returns +true+ if the tweet is a reply to the specified _other_tweet_,
    # returns +false+ otherwise.
    #
    def reply_to?(other_tweet)
      @reply_to == other_tweet
    end

    #
    # Returns the URL of the tweet.
    #
    def url
      "http://twitter.com/#{@user}/status/#{@twitter_id}"
    end

    alias to_s body

  end
end
