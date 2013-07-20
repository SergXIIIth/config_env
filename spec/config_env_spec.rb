require 'config_env'
require 'ostruct'

describe ConfigEnv do
  it 'from code block' do
    config_env do
      set 'omniauth.twitter', 111
    end

    ENV['omniauth.twitter'].should == '111'
  end

  it 'use RACK_ENV' do
    old_rack_env = ENV['RACK_ENV']

    ENV['RACK_ENV'] = 'test'

    config_env :test do
      set 'omniauth.twitter', 'test'
    end

    config_env :production, :development do
      set 'omniauth.twitter', 'live'
    end

    ENV['omniauth.twitter'].should == 'test'

    ENV['RACK_ENV'] = old_rack_env
  end
end