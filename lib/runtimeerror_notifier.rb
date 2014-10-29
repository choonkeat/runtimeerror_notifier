require 'runtimeerror_notifier/notifier'
require 'runtimeerror_notifier/tracker'
require 'runtimeerror_notifier/railtie' if defined?(Rails::Railtie)
require 'runtimeerror_notifier/sidekiq' if defined?(Sidekiq)
require 'runtimeerror_notifier/delayed_job' if defined?(Delayed) && defined?(Delayed::Worker)

module RuntimeerrorNotifier
  def self.for(*emails)
    RuntimeerrorNotifier::Notifier.for(*emails)
    if defined?(::Rails)
      ::Rails.application.config.middleware.insert 0, RuntimeerrorNotifier::Tracker
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
end
