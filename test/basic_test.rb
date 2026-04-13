require "test_helper"

describe MicroFSM, "basics" do
  let(:event) { :event }
  let(:initial) { :initial }
  let(:state_run) { :run }

  def setup
    @fsm = MicroFSM.new(initial)
  end

  def test_class
    assert_kind_of MicroFSM, @fsm
  end

  def test_defines_initial_state
    assert_equal initial, @fsm.state
  end

  def test_returns_an_array_with_the_defined_events
    assert_equal %i[], @fsm.events
  end

  def test_list_the_available_events_for_the_current_state
    assert_equal %i[], @fsm.triggerable_events
  end

  def test_returns_an_array_with_the_defined_states
    assert_equal %i[], @fsm.states
  end

  def test_state_assign
    new_state = :unknown
    refute_equal new_state, @fsm.state
    @fsm.state = new_state
    assert_equal new_state, @fsm.state
  end

  def test_when_concatenation
    fsm2 = @fsm.when(event, initial => state_run)
    assert_equal @fsm, fsm2
    assert_equal [event], @fsm.events
    assert_equal [event], @fsm.triggerable_events
    assert_equal [initial, state_run], @fsm.states
  end
end
