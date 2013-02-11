require 'rails'

module RuntimeerrorNotifier
  class Railtie < ::Rails::Railtie
    rake_tasks do
      require 'runtimeerror_notifier/rake_handler'
    end

    config.after_initialize do
      if defined?(::ActionController::Base)
        require 'runtimeerror_notifier/javascript_notifier'

        ::ActionController::Base.send(:include, RuntimeerrorNotifier::JavascriptNotifier)
      end
    end
  end
end
