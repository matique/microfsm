$LOAD_PATH.push File.expand_path('lib', __dir__)
require 'version'

Gem::Specification.new do |s|
  s.name = "microfsm"
  s.version = MicroFSM::VERSION
  s.summary = %{Minimal Finite State Machine.}
  s.description = %Q{MicroFSM implements a minimal/simple Finite-State Machine (FSM). Transitions are triggered by events. Actions for a transition can be added as callbacks.}
  s.authors  = ['Dittmar Krall']
  s.email    = 'dittmar.krall@matique.de'
  s.homepage = 'https://github.com/matique'
  s.license  = "MIT"
  s.platform = Gem::Platform::RUBY

  s.metadata['source_code_uri'] = 'https://github.com/matique/microfsm'

  s.files = `git ls-files`.split("\n")

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rake'

  s.add_development_dependency 'minitest'
end
