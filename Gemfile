source 'https://rubygems.org'

gem 'bootstrap-sass'

#for alternate style of charts
gem 'chartkick'

#for charts
#gem 'googlecharts'

#for use with chartkick group_by...
gem 'groupdate'

#for font-awesome icons
gem 'font-awesome-rails'

#datatabes for sorting and searching tables
gem 'jquery-datatables-rails', '~> 3.3.0'
gem 'jquery-ui-rails'

#temporary for console ouput formatting
gem 'awesome_print'

gem 'autoprefixer-rails'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.1'
# Use postgres as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Turbo links helper for some js issues related to jquery turbolinks
gem 'jquery-turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
gem 'money-rails' #...cents etc for currency columns
gem 'devise' #user accounts
gem 'carrierwave' #uploading files
gem 'fog' #all-clouds-in-one library 'fog'
# https://github.com/carrierwaveuploader/carrierwave/blob/v0.10.0/README.md

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  #Heroku recommends using a gem called Foreman. This will allow us to use our .env file by accessing the local variables before starting the application. 
  gem 'foreman'
end

group :production do

  #heroku dependency
  gem 'rails_12factor'

end

ruby "2.2.1"
