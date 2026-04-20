require "microfsm"

# This example can be run with ruby -I lib/ ./examples/callbacks.rb

fsm = MicroFSM.new(:idle)
  .when(:confirm, idle: :confirmed) { |ev, ns| puts "Confirmed"; ns }
  .when(:ignore, idle: :ignored) { |ev, ns| puts "Ignored"; ns }
  .when(:reset, confirmed: :idle, ignored: :idle) do |ev, ns|
    puts "Reset"
    ns
  end

puts "Should print Confirmed, Reset and Ignored:"
fsm.trigger(:confirm)
fsm.trigger(:ignore)
fsm.trigger(:reset)
fsm.trigger(:ignore)
