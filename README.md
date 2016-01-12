# ConfigEnv - config your ENV['variables']


[![Code Climate](https://codeclimate.com/github/SergXIIIth/config_env.png)](https://codeclimate.com/github/SergXIIIth/config_env)
[![Dependency Status](https://gemnasium.com/SergXIIIth/config_env.svg)](https://gemnasium.com/SergXIIIth/config_env)


Configurator of the `ENV['key']` for any Ruby environment

- Describe `ENV['key']` variables in config file with Ruby syntax
- Upload the configuration to Heroku


## Usage

```ruby
    gem 'config_env'

    # Specify path your `config_env.rb`
    ConfigEnv.path_to_config("#{__dir__}/config/config_env.rb")
```

Create file `config/env.rb`:

```ruby
    config_env do
      set 'secret_key', 'value_for_all_RACK_ENV'
    end

    config_env :test do
      set 'secret_key', 'overwrite_value_for_test_rack_env'
    end

    config_env :production, :development do
      set 'secret_key', 'overwrite_value_for_test_or_dev_rack_env'
    end
```

For Rails add to `application.rb`

    ConfigEnv.path_to_config("#{__dir__}/env.rb")

Add line to `.gitignore`

    config/env.rb


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
