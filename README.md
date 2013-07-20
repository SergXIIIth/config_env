# ConfigEnv

- Manage ENV[] variables
- Upload ENV to Heroku

Note. It similar to Sinarta configuration

## Installation

Add this line to your application's Gemfile:

    gem 'config_env'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install config_env

## Usage

    config_env :test do
      set 'omniauth.twitter', 'test'
    end

    config_env :production, :development do
      set 'omniauth.twitter', 'live'
    end


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
