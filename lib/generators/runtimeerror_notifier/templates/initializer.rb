# This is a generated configutation file for your RuntimeError.net tracker
# Please obtain the correct email address from RuntimeError.net and change the email below.
if defined?(RuntimeerrorNotifier)
  Rails.application.config.middleware.use RuntimeerrorNotifier::Tracker,
  recipients: ['your-application-email@runtimeerror.net']
end
