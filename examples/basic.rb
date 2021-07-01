require "microfsm"

# This example can be run with ruby -I lib/ ./examples/basic.rb

fsm = MicroFSM.new(:pending)
  .when(:confirm, pending: :confirmed)
  .when(:ignore, pending: :ignored)
  .when(:reset, confirmed: :pending, ignored: :pending)

puts "Should print Confirmed, Reset and Ignored:"

if fsm.trigger(:confirm)
  puts "Confirmed"
end

if fsm.trigger(:ignore)
  puts "Ignored"
end

if fsm.trigger(:reset)
  puts "Reset"
end

if fsm.trigger(:ignore)
  puts "Ignored"
end
