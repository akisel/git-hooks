require 'equalizer'
require 'yaml'

require 'git'

require_relative 'git_hooks/configurations'
require_relative 'git_hooks/git'
require_relative 'git_hooks/config_file'
require_relative 'git_hooks/rspec_executor'
require_relative 'git_hooks/rubocop_validator'

require_relative 'git_hooks/pre_commit'

module GitHooks
  HOOK_SAMPLE_FILE = 'hook.sample'

  class << self
    attr_writer :configurations

    def configurations
      @configurations ||= Configurations.new
    end

    def base_path
      File.absolute_path(File.join(File.expand_path(__FILE__), '..', '..'))
    end

    def hook_installed?(hook)
      absolute_path = File.join(base_path, '.git', 'hooks', hook)
      real_hook_path = File.join(base_path, HOOK_SAMPLE_FILE)

      return false unless File.symlink?(absolute_path)
      File.realpath(absolute_path) == real_hook_path
    end
  end
end
