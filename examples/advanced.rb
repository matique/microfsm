require "microfsm"

# This example can be run with ruby -I lib/ ./examples/advanced.rb

fsm = MicroFSM.new(:idle)
proc = ->(event) { puts fsm.state.capitalize }
fsm.when(:confirm, idle: :confirmed, &proc)
  .when(:ignore, idle: :ignored, &proc)
  .when(:reset, confirmed: :idle, ignored: :idle, &proc)

puts "Should print Confirmed, Pending and Ignored:"
fsm.trigger(:confirm)
fsm.trigger(:ignore)
fsm.trigger(:reset)
fsm.trigger(:ignore)

puts "Should print all states: confirmed, ignored, idle
puts fsm.states.join ", "

puts "Should print all events: confirm, ignore, reset"
puts fsm.events.join ", "
