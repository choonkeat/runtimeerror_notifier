# This is a generated configutation file for your RuntimeError.net tracker
# Please obtain the correct email adress from RuntimeError.net and change the email below.
# And do change the application name to match your application
Rails.application.config.middleware.use RuntimeerrorNotifier::Tracker,
recipients: ['your-application-email@runtimeerror.net']
