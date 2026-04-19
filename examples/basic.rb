require "microfsm"

# This example can be run with ruby -I lib/ ./examples/basic.rb

fsm = MicroFSM.new(:idle)
  .when(:confirm, idle: :confirmed)
  .when(:ignore, idle: :ignored)
  .when(:reset, confirmed: :idle, ignored: :idle)

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
