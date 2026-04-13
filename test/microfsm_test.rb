require "test_helper"

describe MicroFSM do
  let(:fsm) {
    MicroFSM.new(:pending)
      .when(:confirm, pending: :confirmed)
      .when(:ignore, pending: :ignored)
      .when(:reset, confirmed: :pending, ignored: :pending)
  }

  def test_trigger_changes_the_state
    assert fsm.trigger?(:confirm)
    assert fsm.trigger(:confirm)
    assert_equal :confirmed, fsm.state
  end

  def test_preserves_the_state_if_transition_is_not_possible
    refute fsm.trigger?(:reset)
    refute fsm.trigger(:reset)
    assert_equal :pending, fsm.state
  end

  def test_multiple_transitions
    fsm.trigger(:confirm)
    assert_equal :confirmed, fsm.state

    fsm.trigger(:reset)
    assert_equal :pending, fsm.state

    fsm.trigger(:ignore)
    assert_equal :ignored, fsm.state

    fsm.trigger(:reset)
    assert_equal :pending, fsm.state
  end
end
