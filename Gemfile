source 'https://rubygems.org'
ruby '1.9.3'
gem 'rails', '3.2.13'

gem 'jquery-rails'
gem 'bootstrap-sass', '~> 2.3.2.2'
gem 'cancan'
gem 'devise'
gem 'figaro'
gem 'haml-rails'
gem 'rolify'
gem 'simple_form'
gem "awesome_print"
gem 'capistrano'
gem 'whenever', :require => false
gem 'sidekiq', ">= 2.15.0"
gem 'sidekiq-client-cli', ">= 0.1.3"
gem 'sidekiq-failures'
gem 'sinatra', require: false
gem 'airbrake'
gem 'newrelic_rpm'
gem 'gmail' , :github => "90seconds/gmail"
gem 'draper'
gem 'validates_email_format_of'
gem "oauth2"
gem "slim"

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'uglifier', '>= 1.0.3'
  gem 'therubyracer', :platform=>:ruby
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_19, :mri_20, :rbx]
  gem 'html2haml'
  gem 'quiet_assets'
  gem 'rails_layout'
  gem "webrick"
  gem "bullet"
end

group :development, :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails'
end

group :development , :production do
  gem "pg"
end

group :production do
  gem "unicorn"
end

group :test do
  gem 'capybara'
  gem "capybara-webkit"
  gem 'database_cleaner', '1.0.1'
  gem 'email_spec'
  gem 'sqlite3'
  gem "zeus"
  gem "timecop"
end