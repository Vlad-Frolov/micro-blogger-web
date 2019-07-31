source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.2'

gem 'rails', '~> 5.2.3'

gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'imperator', github: 'karmajunkie/imperator'
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5.0'
gem 'sqlite3'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'
gem 'pundit'

group :development, :test do
  gem 'awesome_print'
  gem 'binding_of_caller'
  gem 'brakeman'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'guard', github: 'guard/guard'
  gem 'guard-brakeman'
  gem 'guard-minitest'
  gem 'guard-rubocop'
  gem 'guard-shell'
  gem 'guard-spring'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'minitest-reporters', github: 'kern/minitest-reporters'
  gem 'policy-assertions'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rails-erd'
  gem 'rubocop', '~> 0.59'
  gem 'simplecov', github: 'colszowka/simplecov', require: false
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :development do
  gem 'annotate', require: false
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
