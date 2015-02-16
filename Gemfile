source 'http://rubygems.org'
ruby '2.1.1'

gem 'rails'
gem 'haml'
gem 'jquery-rails'
gem 'pg'
gem 'puma'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
group :development, :test do
  gem 'sqlite3-ruby', :require => 'sqlite3'
  gem 'heroku'
  gem 'webrat'
  gem 'annotate'
end

group :development do
  gem 'awesome_print'
end

group :test do
  gem 'rspec-rails'
  gem 'spork'
  gem 'factory_girl_rails'
  gem 'shoulda-matchers'
end
