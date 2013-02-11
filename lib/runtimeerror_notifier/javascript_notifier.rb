require 'active_support/concern'

module RuntimeerrorNotifier
  module JavascriptNotifier
    extend ActiveSupport::Concern

    included do
      helper_method :runtimeerror_javascript_notifier
    end

    private

    def template_path
      File.join File.dirname(__FILE__), '..', '..', 'templates', 'runtimeerror_notifier', 'javascript_notifier.js.erb'
    end

    def notifier_opts
      {
        file: template_path,
        layout: false,
        use_full_path: false,
        locals: { }
      }
    end

    def runtimeerror_javascript_notifier
      rendered_result = if !@template.nil?
                          @template.render notifier_opts
                        else
                          render_to_string notifier_opts
                        end

      if rendered_result.respond_to?(:html_safe)
        rendered_result.html_safe
      else
        rendered_result
      end
    end

  end
end
