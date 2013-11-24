# RuntimeError.net

This gem acts as the agent for [RuntimeError.net](http://runtimeerror.net). Install the gem for the agent to handle uncaught exceptions from your application.

## Installation (Rails 3)

**Step 1.** Add it as a gem in your __Gemfile__

``` ruby
gem 'runtimeerror_notifier', git: 'git://github.com/develsadvocates/exception_notification_http.git', branch: 'released-v0'
```

**Step 2.** Execute the following command to generate __config/initializers/runtimeerror_notifier.rb__

``` sh
RAILS_ENV=production rails generate runtimeerror_notifier:install
```

**Step 3.** Obtain a secret email address from [RuntimeError.net](http://runtimeerror.net) then set it as environment variable ``RUNTIMEERROR_EMAIL``

## Preventing errors in development

To prevent errors from being sent out while developing, make sure environment variable `RUNTIMEERROR_EMAIL` is unset.

## License

&copy; RuntimeError.net 2013. View LICENSE for details.
