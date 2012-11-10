# ErrorTracking.net

This gem acts as the agent for [ErrorTracking.net](http://errortracking.net). Install the gem for the agent to handle uncaught exceptions from your application.

## Installation

At the moment, we support Rails 3 only. We will extend support to other apps in due time.

### Rails 3 integration

Add it as a gem in your __Gemfile__

``` ruby
gem 'errortracking'
```

After the gem is installed, run the install command to create the configuration files

``` sh
rails generate errortracking --api-key <your-errortracking.net-api-key>
```

A single file called __error_tracking.rb__ will be added under __config/initializers__.

## License

&copy; ErrorTracking.net 2012. View LICENSE for details.
