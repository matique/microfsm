$LOAD_PATH.push File.expand_path('lib', __dir__)
require 'version'

Gem::Specification.new do |s|
  s.name = "microfsm"
  s.version = MicroFSM::VERSION
  s.summary = %{Minimal Finite State Machine.}
#  s.description = %Q{There are many finite state machine implementations for Ruby, and they all provide a nice DSL for declaring events, exceptions, callbacks, and all kinds of niceties in general.\n\nBut if all you want is a finite state machine, look no further: this has less than 50 lines of code and provides everything a finite state machine must have, and nothing more.}
  s.authors  = ['Dittmar Krall']
  s.email    = 'dittmar.krall@matique.de'
  s.homepage = 'http://www.matique.de'
  s.license = "MIT"

  s.files = `git ls-files`.split("\n")

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rake'

  s.add_development_dependency 'minitest'
end
