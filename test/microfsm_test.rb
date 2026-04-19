require "test_helper"

describe MicroFSM do
  let(:fsm) {
    MicroFSM.new(:idle)
      .when(:confirm, idle: :confirmed)
      .when(:ignore, idle: :ignored)
      .when(:reset, confirmed: :idle, ignored: :idle)
  }

  def test_trigger_changes_the_state
    assert fsm.trigger?(:confirm)
    assert fsm.trigger(:confirm)
    assert_equal :confirmed, fsm.state
  end

  def test_preserves_the_state_if_transition_is_not_possible
    refute fsm.trigger?(:reset)
    refute fsm.trigger(:reset)
    assert_equal :idle, fsm.state
  end

  def test_multiple_transitions
    fsm.trigger(:confirm)
    assert_equal :confirmed, fsm.state

    fsm.trigger(:reset)
    assert_equal :idle, fsm.state

    fsm.trigger(:ignore)
    assert_equal :ignored, fsm.state

    fsm.trigger(:reset)
    assert_equal :idle, fsm.state
  end
end
