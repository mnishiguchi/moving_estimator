source 'https://rubygems.org'
# ruby 2.2.1p85 (2015-02-26 revision 49769) [x86_64-darwin14]
gem 'rails', '4.2.1'
gem 'pg',    '~> 0.17.1'

# Default
gem 'sass-rails',   '~> 5.0'
gem 'uglifier',     '~> 2.7.1'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails', '~> 4.0.3'
gem 'turbolinks',   '~> 2.5.3'
gem 'jbuilder',     '~> 2.0'
gem 'sdoc',         '~> 0.4.0', group: :doc
# Views/Styles
gem 'will_paginate',           '~> 3.0.7'   # For pagination.
gem 'bootstrap-will_paginate', '~> 0.0.10'  # Converts pagination to bootstrap style.
gem 'bootstrap-sass',          '~> 3.2.0.0' # Converts Less to Sass.
gem 'font-awesome-rails',      '~> 4.3.0.0' # For icons.
gem 'haml-rails',              '~> 0.9.0'   # For HAML.
# Others
gem 'jquery-turbolinks',       '~> 0.2.1'   # For jQuery to work with turbolinks.
gem 'devise',                  '~> 3.4.1'   # Authentication
gem 'faker',                   '~> 1.4.3'   # Generates sample users.

group :development do
  gem 'dotenv-rails',       '~> 2.0.1'  # Autoloads dotenv in Rails.
  gem 'rails-erd',          '~> 1.3.1'  # For an entity-relationship diagram for models.
end

group :development, :test do
  gem 'rspec-rails',        '~> 3.2.1'  # Testing
  gem 'guard-rspec',        '~> 4.5.0'  # Automates the running of the tests.
  gem 'factory_girl_rails', '~> 4.5.0'  # Alternative to Fixture.
  gem 'byebug',             '~> 3.4.0'  # For the byebug prompt in the terminal.
  gem 'better_errors',      '~> 2.1.1'  # For an error page on the browser.
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
  gem 'growl',              '~> 1.0.3'  # growlnotify bindings
end

group :production do
  gem 'rails_12factor', '~> 0.0.3'   # Enables serving assets in production.
  gem 'puma',           '~> 2.11.2'  # A production webserver
end
