require 'errortracking/notifier'

module ErrorTracking
  class Tracker
    def initialize(app, options={})
      @app, @options = app, options
    end

    def call(env)
     @app.call(env)
    rescue Exception => ex
      ErrorTracking::Notifier.notification(env, ex)
      raise ex
    end
  end
end
