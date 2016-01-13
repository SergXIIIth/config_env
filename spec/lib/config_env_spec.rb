require 'ostruct'

describe ConfigEnv do
  let(:key){ "key_#{rand(1000)}" }
  let(:val){ "val_#{rand(1000)}" }

  before { ConfigEnv.clear }

  describe '.init' do
    let(:path){ double('path') }
    subject(:init) { ConfigEnv.init(path) }

    # on Heroku ENV set manually and config_env does not exist
    context 'when config_env not exist' do
      it 'do nothing' do
        expect(Kernel).to_not receive(:load)
        init
      end
    end

    context 'when config_env exist' do
      before do
        allow(File).to receive(:exists?).with(path){ true }
      end

      it 'load config_env' do
        expect(Kernel).to receive(:load).with(path)
        init
      end
    end
  end

  describe '.vars' do
    it 'returns empty hash by default' do
      ConfigEnv.vars.should == {}
    end

    it 'returns hash of vars' do
      key = key()
      val = val()

      config_env do
        set key, val
      end

      ConfigEnv.vars.should == {key => val}
    end

    it 'returns production and any envs values' do
      key = key()
      val = val()
      key2 = "key2_#{rand(1000)}"
      val2 = "val2_#{rand(1000)}"

      config_env :production do
        set key2, val2
      end

      config_env do
        set key, val
      end

      ConfigEnv.vars('production').should == {key2 => val2, key => val}
    end
  end

  describe 'global shortcut config_env' do
    it 'set ENV from code block' do
      config_env do
        set 'omniauth.twitter', 111
      end

      ENV['omniauth.twitter'].should == '111'
    end

    it 'use RACK_ENV as env swither' do
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

    it 'allow empty in block' do
      config_env do
      end
    end
  end
end
