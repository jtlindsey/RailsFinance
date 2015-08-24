source 'https://rubygems.org'

#for sending 'contact us' emails
# gem 'mail_form'
# gem 'simple_form'

#for bootstrap-sass
gem 'bootstrap-sass', '~> 3.3.5'
gem 'sass-rails', '>= 3.2'

#to get environment variables to load in development and test
gem 'dotenv-rails'#, :groups => [:development, :test]

#for sending emails through app and heroku
gem 'sendgrid'

#for alternate style of charts
gem 'chartkick'

#for use with chartkick group_by...
gem 'groupdate'

#for font-awesome icons
gem 'font-awesome-rails'

#datatabes for sorting and searching tables
gem 'jquery-datatables-rails', '~> 3.3.0'
gem 'jquery-ui-rails'

gem 'autoprefixer-rails'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.1'
# Use postgres as the database for Active Record
gem 'pg'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
gem 'money-rails' #...cents etc for currency columns
gem 'devise' #user accounts
gem 'carrierwave' #uploading files
gem 'fog' #all-clouds-in-one library 'fog'
# https://github.com/carrierwaveuploader/carrierwave/blob/v0.10.0/README.md

group :development, :test do
  #temporary for console ouput formatting
  gem 'awesome_print'

  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  # gem 'web-console', '~> 2.0'

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
