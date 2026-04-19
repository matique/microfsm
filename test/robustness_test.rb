require "test_helper"

describe MicroFSM, "robustness" do
  let(:fsm) {
    MicroFSM.new(:idle)
      .when(:confirm, idle: :confirmed)
      .when(:ignore, idle: :ignored)
      .when(:reset, confirmed: :idle, ignored: :idle)
  }

  it "raises an error if an invalid_event is triggered" do
    assert_raises(MicroFSM::InvalidEvent) do
      fsm.trigger(:random_event)
    end
  end

  it "raises an error if trigger from incompatible state" do
    assert_raises(MicroFSM::InvalidState) do
      fsm.trigger!(:reset)
    end
  end

  it "raises an error if a transition is overwritten" do
    fsm = MicroFSM.new(:init)

    fsm.when(:trigger, init: :started)
    assert_raises(MicroFSM::InvalidTransition) do
      fsm.when(:trigger, init: :wrong)
    end
  end
end
