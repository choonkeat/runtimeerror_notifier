require 'runtimeerror_notifier/notifier'

module RuntimeerrorNotifier
  class Tracker
    def initialize(app, options={})
      @app, @options = app, options
    end

    def call(env)
     @app.call(env)
    rescue Exception => ex
      RuntimeerrorNotifier::Notifier.notification(env, ex)
      raise ex
    end
  end
end
