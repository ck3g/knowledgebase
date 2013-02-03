source 'https://rubygems.org'

gem 'rails', '3.2.11'

gem "mongoid", ">= 3.0.19"
gem "bson_ext", "~> 1.8.2"
gem "devise"
gem "haml-rails"
gem 'jquery-rails'
gem 'anjlab-bootstrap-rails', ">= 2.2", require: 'bootstrap-rails'

gem 'meta-tags', require: "meta_tags"
gem 'simple_form'

gem "cancan", "~> 1.6.8"
gem "faker"

group :assets do
  gem 'sass-rails',   '~> 3.2.6'
  gem 'coffee-rails', '~> 3.2.2'
  gem 'uglifier',     '>= 1.3.0'
  gem "therubyracer"
end

group :development do
  gem "capistrano",         require: false
  gem 'capistrano-recipes', require: false
  gem 'capistrano_colors',  require: false
  gem "erb2haml"
  gem "rails_best_practices"
  gem "thin"
  gem "mailcatcher"
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
