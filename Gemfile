source 'https://rubygems.org'
ruby "2.2.3"

gem 'rails', '~> 4.2.3'
gem 'pg',    '~> 0.17.1'

# Assets
gem 'bower-rails', '~> 0.9.2'
source 'https://rails-assets.org' do
  gem 'rails-assets-fluxxor'
  gem 'rails-assets-growl'
  gem 'rails-assets-jquery.tablesorter'
end

# Default
gem 'sass-rails',   '~> 5.0'
gem 'uglifier',     '~> 2.7.1'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails', '~> 4.0.3'
gem 'turbolinks',   '~> 2.5.3'
gem 'jbuilder',     '~> 2.0'
gem 'sdoc',         '~> 0.4.0', group: :doc
# Views/Styles
gem 'haml-rails'
gem 'bootstrap-sass'
gem 'will_paginate'
gem 'bootstrap-will_paginate'
gem 'font-awesome-rails'
gem 'jquery-ui-rails'
gem 'chart-js-rails'
gem 'react-rails',             '~> 1.0.0'
gem 'sprockets-coffee-react',  '~> 3.0.1'
# Others
gem 'jquery-turbolinks'
gem 'devise', '~> 3.4.1'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-twitter'
gem 'faker'
gem 'growl'

group :development do
  gem 'rails-erd'
end

group :development, :test do
  gem 'dotenv-rails' # Autoloads dotenv in Rails.
  gem 'rspec-rails'
  gem 'guard-rspec'
  gem 'factory_girl_rails'
  gem 'byebug'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'annotate'
  gem 'awesome_print'
  gem 'quiet_assets'
  gem 'spring', '~> 1.1.3'
end

group :test do
  gem 'capybara'
  gem 'capybara-email'
  gem 'selenium-webdriver'
  gem "poltergeist"
  gem 'database_cleaner'
  gem 'launchy'
  gem 'shoulda-matchers', require: false
  gem 'email_spec'
  gem 'json_spec'
end

group :production do
  gem 'rails_12factor', '~> 0.0.3'   # Enables serving assets in production
  gem 'puma',           '~> 2.11.2'  # A production webserver
end
