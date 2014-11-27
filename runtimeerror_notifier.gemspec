Gem::Specification.new do |s|
  s.name         = 'runtimeerror_notifier'
  s.version      = '0.0.24'
  s.platform     = Gem::Platform::RUBY
  s.authors      = ['Wong Liang Zan', 'Chew Choon Keat']
  s.email        = ['zan@liangzan.net', 'choonkeat@gmail.com']
  s.homepage     = 'https://github.com/develsadvocates/runtimeerror_notifier'
  s.summary      = 'Handles uncaught exceptions from your application and integrates tightly with your project management tool.'
  s.description  = 'This gem installs the agent of RuntimeError.net to your application. It handles uncaught exceptions from your application and tightly integrates exceptions with your project management tool.'

  s.required_rubygems_version = '>= 1.3.6'

  s.add_dependency 'httparty', '>= 0.10.0'
  s.add_dependency 'activesupport'
  s.add_dependency 'actionpack'
  s.add_dependency 'actionmailer'
  s.add_dependency 'rake'

  s.add_development_dependency 'rspec', '~> 2.11.0'
  s.add_development_dependency 'shoulda', '~> 3.3.2'
  s.add_development_dependency 'faker'

  s.files = Dir.glob('{lib,templates}/**/*') + %w(LICENSE README.md CHANGELOG.md)
  s.require_path = 'lib'
end
