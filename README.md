# ConfigEnv - config your ENV['variables']

Configurator of the `ENV['key']` for any Ruby environment

- Describe `ENV['key']` variables in config file with Ruby syntax
- Upload the configuration to Heroku


## Usage

    gem 'config_env'

    # Specify path your `config_env.rb`
    ConfigEnv.path_to_config("#{__dir__}/config/config_env.rb")

Create file `config/config_env.rb`:

    # any ENV['RACK_ENV']
    config_env do 
      set 'secret_key', 'value_for_all_RACK_ENV'
    end

    # only when ENV['RACK_ENV'] == :test
    config_env :test do
      set 'secret_key', 'overwrite_value_for_test_rack_env'
    end

    config_env :production, :development do
      set 'secret_key', 'overwrite_value_for_test_or_dev_rack_env'
    end

Add line to `.gitignore`

    config_env.rb


### Upload configurated variables to Heroku

Add to `Rakefile`

    require 'config_env/rake_tasks'
    ConfigEnv.path_to_config("#{__dir__}/config/config_env.rb")

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
