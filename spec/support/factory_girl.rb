# With this set up, factory_girl methods will not need to be prefaced with FactoryGirl.
# https://github.com/thoughtbot/factory_girl/blob/master/GETTING_STARTED.md
RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end
