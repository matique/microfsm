# frozen_string_literal: true

class MicroFSM
  InvalidEvent = Class.new(NoMethodError)
  InvalidState = Class.new(ArgumentError)
  InvalidTransition = Class.new(ArgumentError)

  attr_reader :state

  def initialize(initial_state)
    @state = initial_state
    @transitions_for = {}
    @callbacks_for = {}
  end

  def when(event, transitions, &block)
    @transitions_for[event] ||= {}
    @callbacks_for[event] ||= {}

    transitions.each do |from, to|
      nto = @transitions_for[event][from]
      raise InvalidTransition if nto && nto != to

      @transitions_for[event][from] = to
      @callbacks_for[event][from] ||= []
      @callbacks_for[event][from] << block if block_given?
    end
    self
  end

  def trigger(event)
    trigger?(event) and transit(event)
  end

  def trigger!(event)
    trigger(event) or
      raise InvalidState.new("Event '#{event}' not valid from state '#{@state}'")
  end

  def trigger?(event)
    raise InvalidEvent unless @transitions_for.has_key?(event)

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
    callbacks = @callbacks_for[event][@state]
    @state = @transitions_for[event][@state]
    callbacks.each { |callback| callback.call(event) }
    true
  end
end
