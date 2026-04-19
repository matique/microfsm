require "test_helper"

describe MicroFSM, "robustness" do
  let(:fsm) {
    MicroFSM.new(:idle)
      .when(:confirm, idle: :confirmed)
      .when(:ignore, idle: :ignored)
      .when(:reset, confirmed: :idle, ignored: :idle)
  }

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
