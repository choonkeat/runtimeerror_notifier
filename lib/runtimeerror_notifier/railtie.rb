require 'rails'

module RuntimeerrorNotifier
  class Railtie < ::Rails::Railtie
    rake_tasks do
      require 'runtimeerror_notifier/rake_handler'
    end
  end
end
