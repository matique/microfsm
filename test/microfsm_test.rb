require 'test_helper'

describe MicroFSM do
  let (:fsm) {
    MicroFSM.new(:pending)
            .when(:confirm, pending: :confirmed)
            .when(:ignore, pending: :ignored)
            .when(:reset, confirmed: :pending, ignored: :pending)
  }

  def test_class
    assert_kind_of MicroFSM, fsm
  end

  def test_defines_initial_state
    assert_equal :pending, fsm.state
  end

  def test_changes_the_state
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

  def test_raises_an_error_if_an_invalid_event_is_triggered
    assert_raises(MicroFSM::InvalidEvent) do
      fsm.trigger(:random_event)
    end
  end

  def test_raises_error_if_trigger_from_incompatible_state
    assert_raises(MicroFSM::InvalidState) do
      fsm.trigger!(:reset)
    end
  end

  def test_raises_an_error_if_a_transition_is_overwritten
    fsm = MicroFSM.new(:init)

    fsm.when(:trigger, init: :started)
    assert_raises(MicroFSM::InvalidTransition) do
      fsm.when(:trigger, init: :wrong)
    end
  end
end
