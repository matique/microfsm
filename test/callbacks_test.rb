require "test_helper"

describe MicroFSM do
  let(:fsm) {
    MicroFSM.new(:pending)
      .when(:confirm, pending: :confirmed) { @state = "Confirmed" }
      .when(:reset, confirmed: :pending) { @state = "Pending" }
  }

  def test_executes_callbacks_during_transition
    fsm.trigger(:confirm)
    assert_equal "Confirmed", @state

    fsm.trigger(:reset)
    assert_equal "Pending", @state
  end

  def test_two_callbacks_during_transition
    fsm.when(:confirm, pending: :confirmed) { @state2 = "Confirmed2" }

    fsm.trigger(:confirm)
    assert_equal "Confirmed", @state
    assert_equal "Confirmed2", @state2
  end

  def test_passing_the_event_name_to_the_callbacks
    event_name = nil
    fsm.when(:confirm, pending: :confirmed) do |event|
      event_name = event
    end

    fsm.trigger(:confirm)
    assert_equal :confirm, event_name
  end
end
