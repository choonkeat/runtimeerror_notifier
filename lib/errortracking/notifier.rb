require 'action_dispatch'
require 'action_mailer'
require File.join(File.dirname(__FILE__), 'missing_controller')
require 'pp'

module ErrorTracking
  class Notifier < ActionMailer::Base
    API_ENDPOINT = 'http://127.0.0.1:3000/incoming_emails'
    SENDER_ADDRESS = 'notifier@errortracking.net'
    RECIPIENTS = []
    SECTIONS = %w(request session environment backtrace)
    TEMPLATE_NAME = 'errortracking'

    self.mailer_name = 'errortracking'
    self.append_view_path File.join(File.dirname(__FILE__), '..', '..', 'templates')

    def notification(env, exception, options={})
      email = compose_email(env, exception, options)
      # make post request to end point
    end

    protected

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
      subject = '[Error]'
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
      if Rails && Rails.respond_to?(:backtrace_cleaner)
        Rails.backtrace_cleaner.send(:filter, exception.backtrace)
      else
        exception.backtrace
      end
    end
  end
end
