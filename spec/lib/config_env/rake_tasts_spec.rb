require 'spec_helper'
require 'config_env/rake_tasks'

module ConfigEnv::Tasks
  describe Heroku do
    before { ConfigEnv.clear }

    it 'set use :production as default env'

    describe '#upload_env_to_heroku' do
      it 'set config:set to heroku' do
        heroku = Heroku.new

        key2 = "key2_#{rand(1000)}"
        val2 = "val2_#{rand(1000)}"

        key = "key_#{rand(1000)}"
        val = "val_#{rand(1000)}"

        config_env :production do
          set key2, val2
        end

        config_env do
          set key, val
        end

        expect(heroku).to receive(:heroku){ 'production' }
        expect(heroku).to receive(:heroku).with('config')
        expect(heroku).to receive(:heroku).with("config:set #{key2}=#{val2} #{key}=#{val}")

        heroku.upload_env_to_heroku
      end
    end
  end
end
