require "config_env/version"

module ConfigEnv
  private

  class Command
    def set(key, value)
      ENV[key] = value.to_s
    end
  end
end

def config_env(*envs, &code)
  if envs.size > 0
    env_fit = envs.map{|env| env.to_s}.include?(ENV['RACK_ENV'])
  else
    env_fit = true
  end

  ConfigEnv::Command.new.instance_eval(&code) if env_fit
end
