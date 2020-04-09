source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.0'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'sqlite3'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
# gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Linx Gems
gem "jquery-rails"
gem "devise"
gem "rails_admin"
gem 'faker'
gem 'rails-i18n'
# gem 'loading_screen', '~> 0.2.3'
gem 'loading_screen', git: 'https://github.com/Mujadded/loading_screen.git'
gem "bootstrap", '~> 4.3.1'
gem "font-awesome-rails"
gem "omniauth"
gem 'omniauth-facebook'
gem 'rails-timeago', '~> 2.0'
gem 'listen', '~> 3.1.5'

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  #deploiement

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'meta_request'
  gem "better_errors"
  gem "binding_of_caller"
  gem "timecop"
end

group :production do
  gem 'faraday_middleware-aws-sigv4'
end

gem 'sendgrid-ruby'
gem "dotenv-rails"
gem "aws-sdk-s3", require: false
gem 'passenger'

gem 'capistrano', '~> 3.11'
gem 'capistrano-rails', '~> 1.4'
gem 'capistrano-passenger', '~> 0.2.0'
gem 'capistrano-rbenv', '~> 2.1', '>= 2.1.4'

gem "sinatra"

gem "carrierwave"

gem 'acts-as-taggable-on'
gem 'acts_as_votable'
gem 'acts_as_commentable_with_threading', github: "PlinXXX/acts_as_commentable_with_threading", branch: "master"
# For pagenation
gem 'pagy'

# Wikipedia
gem 'wikipedia-client'

# gem 'searchkick'
gem 'kaminari'
