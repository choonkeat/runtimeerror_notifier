# encoding: utf-8

if Sidekiq::VERSION < '3'
  module RuntimeerrorNotifier
    class Sidekiq
      def call(worker, msg, queue)
        begin
          yield
        rescue Exception => e
          ::RuntimeerrorNotifier::Notifier.notification(msg, e)
          raise
        end
      end
    end
  end
else
  Sidekiq.configure_server do |config|
    config.error_handlers << Proc.new do |e, context|
      ::RuntimeerrorNotifier::Notifier.notification(context, e)
    end
  end
end
