# Glass

A light-weight Rails Engine for API

## Installation

Add this line to your application's Gemfile:

    gem 'glass-api', require: 'glass'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install glass-api

And then run:

    rails generate glass:install

This generator will install Glass. It will also add an initializer in `config/initializer/glass.rb`

    Glass.configure do |config|
      config.models = ['User']
      config.app_name = 'Test App'
      config.format = :json
    end

It will modify your `app/assets/javascripts/application.js`, adding:

    //= require glass

It will modify your `config/routes.rb`, adding:

    mount Glass::Engine => '/api', as: 'glass'

## Usage

Start the server:

    rails server

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
