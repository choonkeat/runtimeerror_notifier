require 'runtimeerror/notifier'

module RuntimeError
  class Tracker
    def initialize(app, options={})
      @app, @options = app, options
    end

    def call(env)
     @app.call(env)
    rescue Exception => ex
      RuntimeError::Notifier.notification(env, ex)
      raise ex
    end
  end
end
