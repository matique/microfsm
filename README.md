# MicroFSM

[![Gem Version](https://img.shields.io/gem/v/microfsm?color=168AFE&logo=rubygems&logoColor=FE1616)](https://rubygems.org/gems/microfsm)
[![Downloads](https://img.shields.io/gem/dt/microfsm?color=168AFE&logo=rubygems&logoColor=FE1616)](https://rubygems.org/gems/microfsm)
[![GitHub Build](https://img.shields.io/github/actions/workflow/status/matique/microfsm/rake.yml?logo=github)](https://github.com/matique/microfsm/actions/workflows/rake.yml)
[![Ruby Style Guide](https://img.shields.io/badge/code_style-standard-168AFE.svg)](https://github.com/standardrb/standard)
[![MIT License](https://img.shields.io/badge/license-MIT-168AFE.svg)](http://choosealicense.com/licenses/mit/)

MicroFSM implements a minimal/simple Finite-State Machine (FSM).
Transitions are triggered by events.
Actions for a transition can be added as callbacks.

Finite-State Machine are described elsewhere, e.g. Wikipedia.

Several FSM implementations are available for Ruby.
Please feel free to use any of them if they fit better to your work.

The MicroFSM code consists of less than 100 locs.
No magic, no niceties, just an implementation using Ruby hashes.

## Installation

As usual:
```ruby
# Gemfile
gem "microfsm"
```
and run "bundle install".

## Usage

```ruby
require 'microfsm'

fsm = MicroFSM.new(:new) # Initial state.

# Define the possible transitions for each event.
#   Template: fsm.when(<event>, <from> => <to>)
fsm.when(:confirm, new: :confirmed)
fsm.when(:ignore, new: :ignored)
fsm.when(:reset, confirmed: :new, ignored: :new)

fsm.trigger(:confirm)  #=> true
fsm.state              #=> :confirmed

fsm.trigger(:ignore)   #=> false
fsm.state              #=> :confirmed

fsm.trigger(:reset)    #=> true
fsm.state              #=> :new

fsm.trigger(:ignore)   #=> true
fsm.state              #=> :ignored
```

You can also ask if an event will trigger a change in state.
Following the example above:

```ruby
fsm.state              #=> :ignored

fsm.trigger?(:ignore)  #=> false
fsm.trigger?(:reset)   #=> true

# And the state is preserved, because you were only asking.
fsm.state              #=> :ignored
```

## Actions

Adding actions to a transition is trivial:

```ruby
fsm.when(:confirm, new: :confirmed) { |event| count += 1 }
fsm.when(:confirm, new: :confirmed) { |event| foo(event) }
```

Two actions/callbacks are triggered in the previous example.


## Miscellaneous

Finally, you can list possible events or states:

```ruby
# All possible events
fsm.events #=> [:confirm, :ignore, :reset]

# All events triggerable from the current state
fsm.triggerable_events #=> [:confirm, :ignore]

# All possible states
fsm.states #=> [:new, :confirmed, :ignored]
```

And, the state can be set (which may be useful for testing purposes):

```ruby
fsm.state = :new
fsm.state              #=> :new
```

Check the _examples_ directory for more information.

## Links

- [Wikipedia](https://en.wikipedia.org/wiki/Finite-state_machine)
- [micromachine](https://github.com/soveran/micromachine)

## Miscellaneous

Copyright (c) 2021-2025 Dittmar Krall (www.matiq.com),
released under the [MIT license](https://opensource.org/licenses/MIT).
