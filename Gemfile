source 'https://rubygems.org'

gem 'rails', '~> 3.2.12'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

group :development do
  gem 'sqlite3'
  gem 'thin-rails'
  gem 'quiet_assets'
end

group :production do
  gem 'mysql2'
end


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
  gem 'bootstrap-sass-rails'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'

group :test, :development do
  gem "rspec-rails", "~> 2.0"
  gem "spork-rails"
end

gem 'haml-rails'
gem 'sass-rails',   '~> 3.2.3'
gem 'secret_token_replacer', :git => 'git://github.com/digineo/secret_token_replacer.git'

gem 'cancan'
gem 'rails-cancan-bootstrap-scaffold', :git => 'git://github.com/ouvrages/rails-cancan-bootstrap-scaffold.git', :branch => "no_title"
