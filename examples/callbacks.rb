require "microfsm"

# This example can be run with ruby -I lib/ ./examples/callbacks.rb

fsm = MicroFSM.new(:idle)
  .when(:confirm, idle: :confirmed) { puts "Confirmed" }
  .when(:ignore, idle: :ignored) { puts "Ignored" }
  .when(:reset, confirmed: :idle, ignored: :idle) {
    puts "Reset"
  }

puts "Should print Confirmed, Reset and Ignored:"
fsm.trigger(:confirm)
fsm.trigger(:ignore)
fsm.trigger(:reset)
fsm.trigger(:ignore)
