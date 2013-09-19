# Glass

[![Gem Version](https://badge.fury.io/rb/glass-api.png)](http://badge.fury.io/rb/glass-api)
[![Build
Status](https://travis-ci.org/TeamSBK/Glass.png?branch=master)](https://travis-ci.org/TeamSBK/Glass)
[![Coverage
Status](https://coveralls.io/repos/TeamSBK/Glass/badge.png?branch=master)](https://coveralls.io/r/TeamSBK/Glass?branch=master)

Glass is a lightweight Rails Engine that is built to do all the heavy lifting from serving an API in your Rails Application.


## Features

* CRUD for your models without a Controller
* Integrates quickly for all client-side Javascript frameworks (Ember, Backbone, Angular)

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

## Mongoid

    class Model
      include Mongoid::Document
      def self.column_names
        self.fields.collect { |field| field[0] }
      end
    end
    
## Usage

#### Ruby

Start the server:

    rails server

#### Javascript

The following usage examples makes use of the Glass API given that you have a
`User` model in your Rails app and you have configured the Glass gem to expose it.

###### Find

Finds a list of records in a model with 'Foo' as name.

```javascript
glass.User.find({
  name: 'Foo'
}, function (res, error) {
  if (!error) {
    // Do something with res
  }
});
```


###### Find All

The following usage example finds all users.

```javascript
glass.User.findAll(function (res, error) {
  if (!error) {
    // Do something with res
  }
});
```


###### Create

Create a new user record.

```javascript
var user = {
  name: 'Jaune Sarmiento',
  email: 'hello@jaunesarmiento.me'
};

glass.User.create(user, function (res, error) {
  if (!error) {
    // Do something with res
  }
});
```

###### Update

Update the user with `id == 1` and update its name to `Joko`.

```javascript
// Given our create() function returns the user object with 1 as id
var user = {
  id: 1,
  name: 'Joko'
};

glass.User.update(user, function (res, error) {
  if (!error) {
    // Do something with res
  }
});
```


###### Delete

Delete a user record with `id == 1`.

```javascript
glass.User.delete({id: 1}, function (res, error) {
  if (!error) {
    // Do something with res
  }
});
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

MIT. See [License] for more details.
Copyright (c) 2013 TeamSBK. Powered by [Proudcloud] Inc.


  [License]: http://github.com/TeamSBK/Glass/blob/master/LICENSE.txt
  [Proudcloud]: http://www.proudcloud.net


