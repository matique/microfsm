require "test_helper"

describe MicroFSM do
  let(:fsm) {
    MicroFSM.new(:idle)
      .when(:confirm, idle: :confirmed) { @state = "Confirmed" }
      .when(:reset, confirmed: :idle) { @state = "Pending" }
  }

  def test_executes_callback_during_transition
    fsm.trigger(:confirm)
    assert_equal "Confirmed", @state

    fsm.trigger(:reset)
    assert_equal "Pending", @state
  end

  def test_passing_the_event_name_to_the_callback
    event_name = nil
    fsm.when(:confirm, idle: :confirmed) do |event|
      event_name = event
    end

    fsm.trigger(:confirm)
    assert_equal :confirm, event_name
  end
end
