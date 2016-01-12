require "config_env/version"

module ConfigEnv
  # path to config_env file. Used in app Rakefile
  def self.path_to_config(new_path)
    @path = new_path
    if File.exists?(path)
      Kernel.load(path)
    end
  end

  def self.path
    @path
  end

  def self.set_vars(vars, envs)
    @vars ||= {}

    envs.each do |env|
      env = env.to_s
      @vars[env] ||= {}
      @vars[env].merge!(vars)
    end
  end

  def self.vars(environment = nil)
    environment ||= self.environment
    environment = environment.to_s

    vars = (vars_hash[environment] || {}).clone
    vars.merge!(vars_hash["any"] || {})

    vars
  end

  def self.clear
    vars_hash.clear
  end

  def self.environment
    ENV['RACK_ENV'] || 'development'
  end

private

  attr_accessor :vars

  def self.vars_hash
    @vars ||= {}
  end

  def self.setup_env(vars, envs)
    if envs == ['any']
      env_fit = true
    else
      env_fit = envs.map{|env| env.to_s}.include?(environment)
    end

    if env_fit
      vars.each do |key, value|
        ENV[key] = value
      end
    end
  end

  class Command
    def set(key, value)
      @vars ||= {}
      @vars[key] = value.to_s
    end

    attr_accessor :vars
  end
end

def config_env(*envs, &code)
  command = ConfigEnv::Command.new
  command.instance_eval(&code)

  envs = envs.size > 0 ? envs : ['any']

  if command.vars
    ConfigEnv.set_vars(command.vars, envs)
    ConfigEnv.setup_env(command.vars, envs)
  end
end
