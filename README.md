MicroFSM
========

[![Gem Version](https://badge.fury.io/rb/micrfsm.svg)](https://badge.fury.io/rb/microfsm)
[![Build Status](https://travis-ci.org/matique/microfsm.svg?branch=master)](https://travis-ci.org/matique/microfsm)

MicroFSM implements a minimal/simple Finite-State Machine (FSM).
Transitions are triggered by events.
Actions for a transition can be added as callbacks.

Finite-State Machine are described elsewhere, e.g. Wikipedia.

Several FSM implementations are available for Ruby.
Please feel free to use any of them if they fit better to your work.

The MicroFSM code consists of less than 70 locs.
No magic, no niceties, just an implementation using Ruby hashes.

Check the examples directory for more information.


Installation
------------

~~~~
# Gemfile
gem "microfsm"

$ bundle install.

# or manually

$ [sudo] gem install microfsm
~~~~

Usage
-----

~~~~
require 'microfsm'

fsm = MicroFSM.new(:new) # Initial state.

# Define the possible transitions for each event.
fsm.when(:confirm, :new => :confirmed)
fsm.when(:ignore, :new => :ignored)
fsm.when(:reset, :confirmed => :new, :ignored => :new)

fsm.trigger(:confirm)  #=> true
fsm.state              #=> :confirmed

fsm.trigger(:ignore)   #=> false
fsm.state              #=> :confirmed

fsm.trigger(:reset)    #=> true
fsm.state              #=> :new

fsm.trigger(:ignore)   #=> true
fsm.state              #=> :ignored
~~~~

You can also ask if an event will trigger a change in state. Following
the example above:

~~~~
fsm.state              #=> :ignored

fsm.trigger?(:ignore)  #=> false
fsm.trigger?(:reset)   #=> true

# And the state is preserved, because you were only asking.
fsm.state              #=> :ignored
~~~~

Actions
-------

Adding actions to a transition is trivial:

~~~~
fsm.when(:confirm, new: :confirmed) { |event| count += 1 }
fsm.when(:confirm, new: :confirmed) { |event| foo(event) }
~~~~

Two actions/callbacks are triggered in the previous example.


Miscellaneous
-------------

Finally, you can list possible events or states:

~~~~
# All possible events
fsm.events #=> [:confirm, :ignore, :reset]

# All events triggerable from the current state
fsm.triggerable_events #=> [:confirm, :ignore]

# All possible states
fsm.states #=> [:new, :confirmed, :ignored]
~~~~

Check the examples directory for more information.

Links
-----

- [Wikipedia](https://en.wikipedia.org/wiki/Finite-state_machine)
- [micromachine](https://github.com/soveran/micromachine)
