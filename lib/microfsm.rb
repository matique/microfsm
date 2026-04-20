require "ricecream"

class MicroFSM
  InvalidEvent = Class.new(NoMethodError)
  InvalidState = Class.new(ArgumentError)
  InvalidTransition = Class.new(ArgumentError)

  attr_accessor :state
  attr_accessor :timed
  attr_accessor :previous_utc
  attr_accessor :current_utc

  def initialize(initial_state)
    @state = initial_state
    @timed = false
    @transitions_for = {}
    @callback_for = {}
  end

  def when(event, transitions, &block)
    @transitions_for[event] ||= {}
    @callback_for[event] ||= {}
    @timed = true if block

    transitions.each do |from, to|
      nto = @transitions_for[event][from]
      raise InvalidTransition if nto && nto != to

      @transitions_for[event][from] = to
      @callback_for[event][from] = block if block
      @current_utc = Time.now.utc if block
    end
    self
  end

  def trigger(event)
    if @timed
      @previous_utc = @current_utc
      @current_utc = Time.now.utc
    end

    trigger?(event) and transit(event)
  end

  def trigger!(event)
    trigger(event) or
      raise InvalidState.new(msg(event))
  end

  def trigger?(event)
    raise InvalidEvent.new(msg(event)) unless @transitions_for.has_key?(event)

    @transitions_for[event].has_key?(state)
  end

  def events
    @transitions_for.keys.sort
  end

  def triggerable_events
    events.select { |event| trigger?(event) }.sort
  end

  def states
    @transitions_for.values.map(&:to_a).flatten.uniq.sort
  end

  private

  def transit(event)
    callback = @callback_for[event][@state]
    next_state = @transitions_for[event][@state]
    next_state = callback.call(event, next_state) if callback
    @state = next_state if next_state
  end

  def msg(event)
    "State: #{@state}; Event: #{event}"
  end
end
