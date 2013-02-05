module RuntimeerrorNotifier
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
