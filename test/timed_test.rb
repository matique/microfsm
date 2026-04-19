require "test_helper"

describe MicroFSM, "timed" do
  it "tests no timed" do
    fsm = MicroFSM.new(:idle)

    refute fsm.timed
    assert_nil fsm.current_utc
  end

  it "tests timed" do
    fsm = MicroFSM.new(:idle)
      .when(:reset, confirmed: :idle) { nil }
    assert fsm.timed
    assert_kind_of Time, fsm.current_utc
  end

  it "checks no change" do
    fsm =  MicroFSM.new(:idle)
      .when(:confirm, idle: :confirmed) { nil }
    previous = fsm.state

    fsm.trigger :confirm
    assert_equal previous, fsm.state
  end

  it "checks changed" do
    fsm =  MicroFSM.new(:idle)
      .when(:confirm, idle: :confirmed) { :changed }
    previous = fsm.state

    fsm.trigger :confirm
    refute_equal previous, fsm.state
  end

  it "checks changed #2" do
    fsm =  MicroFSM.new(:idle)
      .when(:confirm, idle: :confirmed) { |fsm, par| par }
    previous = fsm.state

    fsm.trigger :confirm
    refute_equal previous, fsm.state
    assert_equal :confirmed, fsm.state
  end

  it "checks utc" do
    fsm =  MicroFSM.new(:idle)
      .when(:reset, confirmed: :idle) { nil }
    previous = fsm.previous_utc
    current = fsm.current_utc

    fsm.trigger :reset
    assert_equal current, fsm.previous_utc
    refute_equal current, fsm.current_utc
  end

  it "checks utc untouched" do
    fsm =  MicroFSM.new(:idle)
      .when(:reset, confirmed: :idle)
    previous = fsm.previous_utc
    current = fsm.current_utc

    assert_nil previous
    assert_nil current
    fsm.trigger :reset
    assert_nil fsm.previous_utc
    assert_nil fsm.current_utc
  end
end
