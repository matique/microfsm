$LOAD_PATH.push File.expand_path("lib", __dir__)
require "microfsm/version"

Gem::Specification.new do |s|
  s.name = "microfsm"
  s.version = MicroFSM::VERSION
  s.summary = %(Minimal Finite State Machine.)
  s.description = %{MicroFSM implements a minimal/simple Finite-State Machine (FSM). Transitions are triggered by events. Actions for a transition can be added as callbacks.}
  s.authors = ["Dittmar Krall"]
  s.email = "dittmar.krall@matiq.com"
  s.homepage = "https://github.com/matique/microfsm"
  s.license = "MIT"
  s.platform = Gem::Platform::RUBY

  s.files = Dir["lib/**/*"]
  s.files += Dir["examples/**/*"]
  s.extra_rdoc_files = Dir["README.md", "MIT-LICENSE"]
  s.required_ruby_version = ">= 3"

  s.add_development_dependency "minitest"
  s.add_development_dependency "rake"
end
