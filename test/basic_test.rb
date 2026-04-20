require "test_helper"

describe MicroFSM, "basics" do
  let(:event) { :event }
  let(:initial) { :idle }
  let(:state_run) { :run }

  def setup
    @fsm = MicroFSM.new(initial)
  end

  it "checks class" do
    assert_kind_of MicroFSM, @fsm
  end

  it "checks initial_state" do
    assert_equal initial, @fsm.state
  end

  it "no events; returns an empty array" do
    assert_equal %i[], @fsm.events
  end

  it "no triggerable_events; returns an empty array" do
    assert_equal %i[], @fsm.triggerable_events
  end

  it "no states; returns an empty array" do
    assert_equal %i[], @fsm.states
  end

  it "assigns state" do
    new_state = :unknown
    refute_equal new_state, @fsm.state
    @fsm.state = new_state
    assert_equal new_state, @fsm.state
  end

  it "test when_concatenation" do
    fsm2 = @fsm.when(event, initial => state_run)
    assert_equal @fsm, fsm2
    assert_equal [event], @fsm.events
    assert_equal [event], @fsm.triggerable_events
    assert_equal [initial, state_run], @fsm.states
  end
end
