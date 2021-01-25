require 'test_helper'

describe MicroFSM do
  let (:fsm) {
    MicroFSM.new(:pending)
            .when(:confirm, pending: :confirmed)
            .when(:ignore, pending: :ignored)
            .when(:reset, confirmed: :pending, ignored: :pending)
  }

  def test_returns_an_array_with_the_defined_events
    assert_equal %i[confirm ignore reset], fsm.events
  end

  def test_list_the_available_events_for_the_current_state
    assert_equal %i[confirm ignore], fsm.triggerable_events
  end

  def test_returns_an_array_with_the_defined_states
    assert_equal %i[confirmed ignored pending], fsm.states
  end
end
