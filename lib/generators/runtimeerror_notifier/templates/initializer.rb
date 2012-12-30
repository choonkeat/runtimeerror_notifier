if defined?(RuntimeerrorNotifier)
  # Get your secret email address from RuntimeError.net and change value below
  RuntimeerrorNotifier.for 'secret_email_generated_for_you@runtimeerror.net'
  RuntimeerrorNotifier::Notifier::IGNORED_EXCEPTIONS.push(*%w[
    ActionController::RoutingError
  ])
end
