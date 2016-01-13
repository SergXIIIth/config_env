require "config_env/version"

module ConfigEnv
  # DEPRECATED. Use `init`
  def self.path_to_config(new_path)
    init(new_path)
  end

  def self.init(path_to_config)
    @path = path_to_config
    Kernel.load(path) if File.exists?(path)
  end

  def self.path
    @path
  end

  def self.vars(environment = nil)
    environment = (environment || self.environment).to_s

    vars = (vars_hash[environment] || {}).clone
    vars.merge!(vars_hash["any"] || {})

    vars
  end

  def self.clear
    vars_hash.clear
  end

  def self.environment
    ENV['RAILS_ENV'] || ENV['RACK_ENV'] || 'development'
  end

private

  def self.set_envs(vars, envs)
    envs = envs.map(&:to_s)

    envs.each do |env|
      vars_hash[env] ||= {}
      vars_hash[env].merge!(vars)
    end

    if envs == ['any'] || envs.include?(environment)
      vars.each do |key, value|
        ENV[key] = value
      end
    end
  end

  def self.vars_hash
    @vars ||= {}
  end

  class EnvWrap
    def initialize
      @vars = {}
    end

    def set(key, value)
      @vars[key] = value.to_s
    end

    attr_accessor :vars
  end
end

def config_env(*envs, &code)
  env_wrap = ConfigEnv::EnvWrap.new
  env_wrap.instance_eval(&code)

  envs = envs.size > 0 ? envs : ['any']

  ConfigEnv.set_envs(env_wrap.vars, envs)
end
