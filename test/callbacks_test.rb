require "test_helper"

describe MicroFSM do
  let(:fsm) { MicroFSM.new(:idle) }

  it "executes callback during transition"do
    fsm.when(:confirm, idle: :confirmed) { @state = "Confirmed" }

    fsm.trigger(:confirm)
    assert_equal "Confirmed", @state
  end

  it "passes event to callback" do
    event_name = nil
    fsm.when(:confirm, idle: :confirmed) do |event, next_state|
      event_name = event
      next_state
    end

    fsm.trigger(:confirm)
    assert_equal :confirm, event_name
    assert_equal :confirmed, fsm.state
  end

  it "passes event and next_state to callback" do
    event_name = nil
    next_state = nil
    fsm.when(:confirm, idle: :confirmed) do |event, state|
      event_name = event
      next_state = state
    end

    fsm.trigger(:confirm)
    assert_equal :confirm, event_name
    assert_equal :confirmed, next_state
  end
end
