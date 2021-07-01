require "microfsm"

# This example can be run with ruby -I lib/ ./examples/callbacks.rb

fsm = MicroFSM.new(:pending)
  .when(:confirm, pending: :confirmed) { puts "Confirmed" }
  .when(:ignore, pending: :ignored) { puts "Ignored" }
  .when(:reset, confirmed: :pending, ignored: :pending) {
  puts "Reset"
}

puts "Should print Confirmed, Reset and Ignored:"
fsm.trigger(:confirm)
fsm.trigger(:ignore)
fsm.trigger(:reset)
fsm.trigger(:ignore)
