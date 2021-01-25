require 'microfsm'

# This example can be run with ruby -I lib/ ./examples/advanced.rb

fsm = MicroFSM.new(:pending)
proc = -> (event) { puts fsm.state.capitalize }
fsm.when(:confirm, :pending => :confirmed, &proc)
   .when(:ignore,  :pending => :ignored, &proc)
   .when(:reset,   :confirmed => :pending, :ignored => :pending, &proc)

puts "Should print Confirmed, Pending and Ignored:"
fsm.trigger(:confirm)
fsm.trigger(:ignore)
fsm.trigger(:reset)
fsm.trigger(:ignore)

puts "Should print all states: confirmed, ignored, pending"
puts fsm.states.join ", "

puts "Should print all events: confirm, ignore, reset"
puts fsm.events.join ", "
