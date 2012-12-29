# RuntimeError.net

This gem acts as the agent for [RuntimeError.net](http://runtimeerror.net). Install the gem for the agent to handle uncaught exceptions from your application.

## Installation

At the moment, we support Rails 3 only. We will extend support to other apps in due time.

### Rails 3 integration

Add it as a gem in your __Gemfile__

``` ruby
gem 'runtimeerror_notifier', git: 'git://github.com/develsadvocates/exception_notification_http.git', branch: 'released-v0'
```

After the gem is installed, run the install command to create the configuration files

``` sh
rails generate runtimeerror_notifier:install
```

NOTE: add ``RAILS_ENV=production`` if you've only added the gem into your ``:production`` group; Or you can simply create the file (and its content) mentioned below

The file __config/initializers/runtimeerror_notifier.rb__ will be created with the following content:

``` ruby
if defined?(RuntimeerrorNotifier)
  RuntimeerrorNotifier.for 'secret_email_generated_for_you@runtimeerror.net'
end
```

Obtain the email address by configuring your repository at [RuntimeError.net](http://runtimeerror.net)

## License

&copy; RuntimeError.net 2012. View LICENSE for details.
