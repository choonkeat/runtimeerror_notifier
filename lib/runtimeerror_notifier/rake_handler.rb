require 'rake'

module RuntimeerrorNotifier
  module RakeHandler
    def self.included(base)
      base.class_eval do
        alias_method :display_errors_without_runtimeerror, :display_error_message
        alias_method :display_error_message, :display_errors_with_runtimeerror
      end
    end

    def display_errors_with_runtimeerror(excp)
      RuntimeerrorNotifier::Notifier.notification(environment_info, excp)
      display_errors_without_runtimeerror(excp)
    end

    def environment_info
      { component: 'rake', action: command_line_info, rake_env: ENV}
    end

    def command_line_info
      ARGV.join(' ')
    end
  end
end

# Hook to capture rake errors
Rake.application.instance_eval do
  if !ENV['RAILS_ENV'].nil? && ENV['RAILS_ENV'] != 'development'
    class << self
      include RuntimeerrorNotifier::RakeHandler
    end
  end
end
