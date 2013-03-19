source 'https://rubygems.org'

gem 'rails', '3.2.13'

gem "json", "~> 1.7.7"
gem "mongoid", ">= 3.0.19"
gem "bson_ext", "~> 1.8.2"
gem "devise", "~> 2.2.3"
gem "haml-rails"
gem 'jquery-rails', "2.1.4"
gem 'anjlab-bootstrap-rails', ">= 2.2", require: 'bootstrap-rails'
gem "fancybox2-rails", "~> 0.2.1"

gem 'meta-tags', require: "meta_tags"
gem 'simple_form'

gem "cancan", "~> 1.6.8"
gem "faker"
gem "carrierwave-mongoid", "~> 0.3.0", require: "carrierwave/mongoid"
gem "mini_magick", "~> 3.4"
gem "redcarpet", "~> 2.2.2"
gem "pygments.rb", "~> 0.3.7"

gem "newrelic_rpm"

group :assets do
  gem 'sass-rails',   '~> 3.2.6'
  gem 'coffee-rails', '~> 3.2.2'
  gem 'uglifier',     '>= 1.3.0'
  gem "therubyracer"
  gem "jquery-fileupload-rails"
end

group :development do
  gem "capistrano",         require: false
  gem 'capistrano-recipes', require: false
  gem 'capistrano_colors',  require: false
  gem "rvm-capistrano"
  gem 'capistrano-unicorn', '~> 0.1.6', require: false
  gem "erb2haml"
  gem "rails_best_practices"
  gem "thin"
  gem "mailcatcher"
  gem "zeus"
end

group :development, :test do
  gem 'rspec-rails',        '~> 2.12.2'
  gem 'factory_girl_rails', '~> 4.1.0'
  gem "pry-rails"
end

group :test do
  gem "launchy"
  gem "capybara",           "~> 2.0.2"
  gem "database_cleaner"
  gem "shoulda"
  gem "email_spec"
  gem "mongoid-rspec", ">= 1.5.6"
end

group :production do
  gem "unicorn"
end
