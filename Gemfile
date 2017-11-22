source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.4'
# Use Puma as the app server
gem 'puma', '~> 3.7'
gem 'pg', '~> 0.18'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'
gem 'cancancan', '~> 2.0'
gem 'devise_token_auth', '~> 0.1.42'
gem 'omniauth', '~> 1.7', '>= 1.7.1'
gem 'fog-aws', '~> 1.4', '>= 1.4.1'
gem 'mini_magick', '~> 4.8'
gem 'dotenv-rails', '~> 2.2'
gem 'apipie-rails', '~> 0.5.5'
gem 'acts_as_list', '~> 0.9.9'
gem 'rack-cors', '~> 1.0', '>= 1.0.2', require: 'rack/cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'selenium-webdriver'
  gem 'rspec-rails', '~> 3.5'
  gem 'database_cleaner', '~> 1.6', '>= 1.6.1'
  gem 'capybara', '~> 2.14', '>= 2.14.4'
  gem 'transactional_capybara', '~> 0.2.0'
  gem 'factory_bot_rails', '~> 4.8', '>= 4.8.2'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'rubycritic', '~> 3.3', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
