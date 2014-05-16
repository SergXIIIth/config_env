# ConfigEnv

Configurator of the `ENV['key']` for any Ruby environment

- Describe `ENV['key']` variables in config file with Ruby syntax
- Upload the configured variables to Heroku


## Usage

    gem 'config_env'

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

### Upload configurated variables to Heroku

Add lines to `Rakefile`

    require 'config_env/rake_tasks'
    ConfigEnv.path = "#{__dir__}/ruby/config/config_env.rb"

Run rake command

    rake config_env:heroku

Optionally, you can pass in the name of the Heroku app

    rake config_env:heroku[app-name]

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
