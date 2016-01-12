ENV['RACK_ENV'] = 'test'

require 'config_env'

Dir["#{__dir__}/support/**/*.rb"].each{ |path| require path }

RSpec.configure do |config|
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
end

