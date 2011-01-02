require 'iconv'

module Gawker
  include Ronin

  #
  # Parses the cracked passwords file.
  #
  # @yield [user, password, email]
  #   The given block will be passed every user name, password and email
  #   address.
  #
  # @yieldparam [String] user
  #
  # @yieldparam [String] password
  #
  # @yieldparam [String] email
  #
  def Gawker.parse(path)
    File.open(path) do |file|
      sanitizer = Iconv.new('UTF-8//IGNORE', 'UTF-8')

      file.each_line do |line|
        fields = sanitizer.iconv(line).split(':',4)

        if fields.length == 4
          yield fields[0], fields[1], fields[3]
        end
      end
    end
  end

  #
  # Imports the user names, cracked passwords and email addresses into the
  # Ronin Database.
  #
  # @yield [cred]
  #   The given block will be passed each new credential.
  #
  # @yieldparam [WebCredential] cred
  #   An imported credential.
  #
  def Gawker.import(path)
    url = URL.parse('http://gawker.com/')

    parse(path) do |user,password,email|
      email = begin
                EmailAddress.parse(email)
              rescue
                next
              end
      user = UserName.first_or_create(:name => user)
      password = Password.first_or_create(:clear_text => password)

      # also lookup the IP addresses of the email host name
      email.host_name.lookup! if email.host_name.new?

      yield WebCredential.create(
        :user_name => user,
        :email_address => email,
        :password => password,
        :url => url
      )
    end
  end
end
