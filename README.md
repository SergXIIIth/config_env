# Configurate ENV with Ruby syntax. Upload to Heroku


[![Code Climate](https://codeclimate.com/github/SergXIIIth/config_env.png)](https://codeclimate.com/github/SergXIIIth/config_env)
[![Dependency Status](https://gemnasium.com/SergXIIIth/config_env.svg)](https://gemnasium.com/SergXIIIth/config_env)


Features:

- Describe `ENV['key']` configuration with Ruby syntax
- Upload configuration to Heroku


## Usage

```ruby
    gem 'config_env'
    ConfigEnv.init("#{__dir__}/env.rb")
```

Create file `config/env.rb`:

```ruby
    config_env do
      set 'all_env_key', '1'
    end

    config_env :test do
      set 'test_key', '2'
    end

    config_env :production, :development do
      set 'production_and_development_key', '3'
    end
```

Add to `application.rb`

```ruby
    ConfigEnv.init("#{__dir__}/env.rb")
```

Add line to `.gitignore`

    config/env.rb


### Upload configurated variables to Heroku

Add to `Rakefile`

```ruby
    require 'config_env/rake_tasks'
    ConfigEnv.init("#{__dir__}/config/env.rb")
```

Run

```bash
    rake config_env:heroku
    rake config_env:heroku[app]
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
