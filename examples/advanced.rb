require "microfsm"

# This example can be run with ruby -I lib/ ./examples/advanced.rb

fsm = MicroFSM.new(:idle)
proc = ->(event, next_state) { puts next_state.capitalize; next_state }
fsm.when(:confirm, idle: :confirmed, &proc)
  .when(:ignore, idle: :ignored, &proc)
  .when(:reset, confirmed: :idle, ignored: :idle, &proc)

puts "Should print Confirmed, Idle and Ignored:"
fsm.trigger(:confirm)
fsm.trigger(:ignore)
fsm.trigger(:reset)
fsm.trigger(:ignore)

puts "Should print all states: confirmed, idle, ignored"
puts fsm.states.join ", "

puts "Should print all events: confirm, ignore, reset"
puts fsm.events.join ", "
