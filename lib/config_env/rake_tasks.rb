require 'bundler'
require 'rake'
require 'shellwords'
require 'config_env'

module ConfigEnv
  module Tasks
    class Heroku
      def initialize(app=nil)
        @app = app
        unless ConfigEnv.path.nil?
          fail unless load(ConfigEnv.path)
        end
      end

      def upload_env_to_heroku
        puts "Configure Heroku according to config_env[#{environment}]"
        heroku("config:set #{vars}")
        puts ''
        puts heroku('config')
      end

      private

      def puts(message)
        super unless ENV['RACK_ENV'] == 'test'
      end

      def vars
        ConfigEnv.vars(environment).map { |key, value|
          "#{key}=#{Shellwords.escape(value)}"
        }.sort.join(" ")
      end

      def environment
        @environment ||= heroku("run 'echo $RACK_ENV'").chomp[/(\w+)\z/]
      end

      def heroku(command)
        with_app = @app ? " --app #{@app}" : ''
        `heroku #{command}#{with_app}`
      end
    
      def `(command)
        Bundler.with_clean_env { super }
      end
    end
  end
end

namespace :config_env do
  desc 'Configure Heroku according to config_env'
  task :heroku, [:app] do |_, args|
    ConfigEnv::Tasks::Heroku.new(args[:app]).upload_env_to_heroku
  end
end
