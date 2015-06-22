# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

# Command line options used when running browserify
Rails.application.config.browserify_rails.commandline_options =
  # To compile coffeescript + react jsx (cjsx) automatically
  "-t coffee-reactify --extension=\".js.cjsx\" --extension=\".js.coffee\""
