require 'action_dispatch'
require 'action_mailer'
require 'pp'
require 'httparty'
require File.join(File.dirname(__FILE__), 'missing_controller')

module RuntimeerrorNotifier
  class Notifier < ActionMailer::Base
    API_ENDPOINT = 'http://runtimeerror.net/incoming_emails'
    SENDER_ADDRESS = 'notifier@runtimeerror.net'
    RECIPIENTS = []
    SECTIONS = %w(request session environment backtrace)
    TEMPLATE_NAME = 'runtimeerror_notifier'

    self.mailer_name = 'runtimeerror_notifier'
    self.append_view_path File.join(File.dirname(__FILE__), '..', '..', 'templates')

    def notification(env, exception, options={})
      email = compose_email(env, exception, options)
      make_request(email)
      email
    end

    protected

    def make_request(email)
      HTTParty.post(API_ENDPOINT, body: {message: email.to_s})
    end

    def compose_email(env, exception, options)
      @attr = exception_attributes(env, exception, options)
      mail(:to => @attr[:recipients],
           :from => @attr[:sender_address],
           :subject => compose_subject(@attr),
           :template_name => TEMPLATE_NAME) do |format|
        format.text
      end
    end

    def exception_attributes(env, exception, options={})
      {
        env: env,
        exception: exception,
        api_endpoint: options[:api_endpoint] || API_ENDPOINT,
        kontroller: env['action_controller.instance'] || MissingController.new,
        request: ActionDispatch::Request.new(env),
        backtrace: exception.backtrace ? clean_backtrace(exception) : [],
        recipients: options[:recipients] || RECIPIENTS,
        sender_address: options[:sender_address] || SENDER_ADDRESS,
        sections: SECTIONS
      }
    end

    def compose_subject(attr)
      subject = ''
      subject << formatted_controller_name(attr[:kontroller])
      subject << " (#{attr[:exception].class})"
      subject << " #{attr[:exception].message.inspect}"
      shorten_subject(subject)
    end

    def formatted_controller_name(kontroller)
      if kontroller.present?
        "#{kontroller.controller_name}##{kontroller.action_name}"
      else
        ''
      end
    end

    def shorten_subject(subject)
      subject.length > 120 ? subject[0...120] + "..." : subject
    end

    def clean_backtrace(exception)
      if defined?(Rails) && Rails.respond_to?(:backtrace_cleaner)
        Rails.backtrace_cleaner.send(:filter, exception.backtrace)
      else
        exception.backtrace
      end
    end

    def inspect_object(object)
      case object
      when Hash, Array
        object.inspect
      when ActionController::Base
        "#{object.controller_name}##{object.action_name}"
      else
        object.to_s
      end
    end
    helper_method :inspect_object

  end
end
