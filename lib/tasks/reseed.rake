# Originally written by Justin French (2008):
# http://justinfrench.com/notebook/a-custom-rake-task-to-reset-and-seed-your-database
# Modified to work with Rails 4.
# https://gist.github.com/nithinbekal/3423153

desc 'Raise an error unless development environment'
task :safety_check do
  raise "You can only use this in dev!" unless Rails.env.development?
end

namespace :db do
  desc 'Reset database then seed the development database'
  task reseed: [
    'environment',
    'safety_check',
    'db:reset',
    'db:seed'
  ]
end
