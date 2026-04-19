require "test_helper"

describe MicroFSM do
  let(:fsm) {
    MicroFSM.new(:idle)
      .when(:confirm, idle: :confirmed)
      .when(:ignore, idle: :ignored)
      .when(:reset, confirmed: :idle, ignored: :idle)
  }

  def test_returns_an_array_with_the_defined_events
    assert_equal %i[confirm ignore reset], fsm.events
  end

  def test_list_the_available_events_for_the_current_state
    assert_equal %i[confirm ignore], fsm.triggerable_events
  end

  def test_returns_an_array_with_the_defined_states
    assert_equal %i[confirmed idle ignored], fsm.states
  end
end
