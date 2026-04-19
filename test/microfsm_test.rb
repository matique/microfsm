require "test_helper"

describe MicroFSM do
  let(:fsm) {
    MicroFSM.new(:idle)
      .when(:confirm, idle: :confirmed)
      .when(:ignore, idle: :ignored)
      .when(:reset, confirmed: :idle, ignored: :idle)
  }

  it "changes the state" do
    assert fsm.trigger?(:confirm)
    assert fsm.trigger(:confirm)
    assert_equal :confirmed, fsm.state
  end

  it "preserves the state if transition is not possible" do
    refute fsm.trigger?(:reset)
    refute fsm.trigger(:reset)
    assert_equal :idle, fsm.state
  end

  it "tests multiple transitions" do
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
