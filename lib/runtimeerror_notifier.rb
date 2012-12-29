require 'runtimeerror_notifier/notifier'

module RuntimeerrorNotifier
  def self.for(*emails)
    RuntimeerrorNotifier::Notifier.for(*emails)
    if defined?(::Rails)
      ::Rails.application.config.middleware.insert 0, 'Rack::Runtime', RuntimeerrorNotifier::Tracker
    end
    renderer_class = if defined?(::ActionDispatch::DebugExceptions)
      ::ActionDispatch::DebugExceptions
    elsif defined?(::ActionDispatch::ShowExceptions)
      ::ActionDispatch::ShowExceptions
    end
    if renderer_class
      renderer_class.class_eval do
        def render_exception_with_runtimeerror_notifier(env, exception)
          begin
            RuntimeerrorNotifier::Notifier.notification(env, exception, {})
          rescue Exception
            # do nothing
          end
          render_exception_without_runtimeerror_notifier(env, exception)
        end
        alias_method_chain :render_exception, :runtimeerror_notifier
      end
    end
  end
  class Tracker
    def initialize(app, options={})
      @app, @options = app, options
    end

    def call(env)
      @app.call(env)
    rescue Exception => ex
      RuntimeerrorNotifier::Notifier.notification(env, ex, @options)
      raise ex
    end
  end
end
