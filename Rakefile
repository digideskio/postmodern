begin
  gem 'yard', '~> 0.7.0'
  require 'yard'
  
  YARD::Rake::YardocTask.new
rescue LoadError
  task :yard do
    abort "Please run `gem install yard` to install YARD."
  end
end
