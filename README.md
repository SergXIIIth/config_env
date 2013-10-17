# ConfigEnv

ENV manager for any Ruby code

- Manage ENV[] variables
- Upload ENV to Heroku

Note. It similar to Sinarta configuration

## Installation

Add to Gemfile (as top as possible):

    gem 'config_env'

And then execute:

    $ bundle


## Usage

Create file `config_env.rb`:

    # any ENV['RACK_ENV']
    config_env do 
      set 'omniauth.twitter', 'all'
    end

    # only when ENV['RACK_ENV'] == :test
    config_env :test do
      set 'omniauth.twitter', 'test'
    end

    config_env :production, :development do
      set 'omniauth.twitter', 'live'
    end

Add line to `.gitignore`

    config_env.rb

### Heroku

If you want use set env at Heroku. Add lines to `Rakefile`

    require 'config_env/rake_tasks'
    ConfigEnv.path = "#{__dir__}/ruby/config/config_env.rb"

Configure Heroku according to config_env

    rake config_env:heroku

Optionally, you can pass in the name of the Heroku app:

    rake config_env:heroku[app-name]

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
