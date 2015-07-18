source 'https://rubygems.org'
# ruby 2.2.1p85 (2015-02-26 revision 49769) [x86_64-darwin14]
gem 'rails',       '~> 4.2.1'
gem 'pg',          '~> 0.17.1'

# Assets
gem 'bower-rails', '~> 0.9.2'
source 'https://rails-assets.org' do
  gem 'rails-assets-fluxxor'
  gem 'rails-assets-growl'
  gem 'rails-assets-react-bootstrap'
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
gem 'haml-rails',              '~> 0.9.0'   # For HAML.
gem 'bootstrap-sass',          '~> 3.2.0.0' # Converts Less to Sass.
gem 'will_paginate',           '~> 3.0.7'   # For pagination.
gem 'bootstrap-will_paginate', '~> 0.0.10'  # For bootstrap pagination style.
gem 'font-awesome-rails',      '~> 4.3.0.0' # For icons.
gem 'jquery-ui-rails',         '~> 5.0.5'   # For autocomplete etc
gem 'chart-js-rails'
# React
gem 'react-rails',             '~> 1.0.0'   # Compiles JSX.
gem 'sprockets-coffee-react',  '~> 3.0.1'   # Preprocessor for Coffeescript with React JSX (CJSX).
# gem 'browserify-rails',        '~> 1.0.1'   # Adds CommonJS module support to Sprockets (via Browserify)
# Others
gem 'jquery-turbolinks',       '~> 2.1.0'   # For jQuery to work with turbolinks.
gem 'devise',                  '~> 3.4.1'   # Authentication
gem 'gibbon',                  '~> 1.1.5'   # A wrapper for MailChimp API 2.0 and Export API 1.0
gem 'faker',                   '~> 1.4.3'   # Generates sample users.
gem 'growl',                   '~> 1.0.3'   # Growlnotifies bindings.
gem 'pg_search',               '~> 1.0.3'   # Named scopes that take advantage of PostgreSQL's full text search

group :development do
  gem 'dotenv-rails',       '~> 2.0.1'  # Autoloads dotenv in Rails.
  gem 'rails-erd',          '~> 1.3.1'  # Run bundle exec erd to print an entity-relationship diagram.
end

group :development, :test do
  gem 'rspec-rails',        '~> 3.3.2'
  gem 'guard-rspec',        '~> 4.5.0'  # Automates the running of the tests.
  gem 'factory_girl_rails', '~> 4.5.0'  # Alternative to Fixture.
  gem 'byebug',             '~> 3.4.0'  # The byebug prompt in the terminal.
  gem 'better_errors',      '~> 2.1.1'  # An error page on the browser.
  gem 'binding_of_caller',  '~> 0.7.2'  # For the binding of a method's caller.
  gem 'annotate',           '~> 2.6.8'  # Annotates models.
  gem 'awesome_print',      '~> 1.6.1'  # Pretty-prints Ruby objects.
  gem 'quiet_assets',       '~> 1.1.0'  # Turns off Rails asset pipeline log.
  gem 'spring',             '~> 1.1.3'
end

group :test do
  gem 'selenium-webdriver', '~> 2.45.0'
  gem 'capybara',           '~> 2.4.4'
  gem 'database_cleaner',   '~> 1.4.1'
  gem 'launchy',            '~> 2.4.3'
  gem 'shoulda-matchers', require: false
  gem 'json_spec',          '~> 1.1.4'
end

group :production do
  gem 'rails_12factor', '~> 0.0.3'   # Enables serving assets in production.
  gem 'puma',           '~> 2.11.2'  # A production webserver
end
