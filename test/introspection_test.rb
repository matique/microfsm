require "test_helper"

describe MicroFSM do
  let(:fsm) {
    MicroFSM.new(:idle)
      .when(:confirm, idle: :confirmed)
      .when(:ignore, idle: :ignored)
      .when(:reset, confirmed: :idle, ignored: :idle)
  }

  it "returns array with the defined events" do
    assert_equal %i[confirm ignore reset], fsm.events
  end

  it "returns the available events for the current state" do
    assert_equal %i[confirm ignore], fsm.triggerable_events
  end

  it "returns the defined states" do
    assert_equal %i[confirmed idle ignored], fsm.states
  end
end
