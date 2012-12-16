class RuntimeerrorNotifier::InstallGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  desc 'Creates an initializer file for RuntimeError.net at config/initializers'

  def install
    template 'initializer.rb', 'config/initializers/runtimeerror_notifier.rb'
  end
end
