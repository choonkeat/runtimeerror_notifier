# RuntimeError.net

This gem acts as the agent for [RuntimeError.net](http://runtimeerror.net). Install the gem for the agent to handle uncaught exceptions from your application.

## Installation

At the moment, we support Rails 3 only. We will extend support to other apps in due time.

### Rails 3 integration

Add it as a gem in your __Gemfile__

``` ruby
gem 'runtimeerror_notifier'
```

After the gem is installed, run the install command to create the configuration files

``` sh
rails generate runtimeerror_notifier:install
```

A single file called __runtimeerror_notifier.rb__ will be added under __config/initializers__ with content similar to below:

``` ruby
YourApplicationName::Application.config.middleware.use RuntimeerrorNotifier::Tracker,
recipients: ['foo+qqkv9p8p-xx6v6j6fditzw@runtimeerror.net']
```

You may obtain the email address by configuring your repository at [RuntimeError.net](http://runtimeerror.net)

## License

&copy; RuntimeError.net 2012. View LICENSE for details.
