class ObjectEventPublisher
  def initialize
    @event_to_subscribers = Hash.new []
  end

  def subscribe(event, &subscriber_block)
    @event_to_subscribers[event] << subscriber_block
  end

  def emit(event)
    @event_to_subscribers[event.class].each do |block|
      block.call(event)
    end
  end
end

class SimpleEvent
  attr_reader :a, :b

  def initialize(a, b)
    @a = a
    @b = b
  end
end

class ObjectEventSubscriber
  def initialize(publisher)
    publisher.subscribe(SimpleEvent) do |event| simple_event(event) end
  end

  def simple_event(event)
    event.a + event.b
  end
end

object_publisher = ObjectEventPublisher.new
ObjectEventSubscriber.new object_publisher
object_publisher.emit(SimpleEvent.new 1, 2)


class SymbolEventPublisher
  def initialize
    @event_to_subscribers = Hash.new []
  end

  def subscribe(event, subscriber)
    @event_to_subscribers[event] << subscriber
  end

  def emit(event, *args)
    @event_to_subscribers[event].each do |subscriber|
      subscriber.public_send(event, *args)
    end
  end
end

class SymbolEventSubscriber
  def initialize(publisher)
    publisher.subscribe :simple_event, self
  end

  def simple_event(payload)
    payload[:a] + payload[:b]
  end
end

symbol_publisher = SymbolEventPublisher.new
SymbolEventSubscriber.new symbol_publisher
symbol_publisher.emit :simple_event, {a: 1, b: 2}

require 'event_bus'
class SymbolSubscriber
  def simple_event(payload)
    payload[:a] + payload[:b]
  end
end


EventBus.subscribe SymbolSubscriber.new
EventBus.announce :simple_event, a: 1, b: 2

require 'wisper'

class WisperPublisher
  include Wisper::Publisher

  def emit(event, a, b)
    publish event, a, b
  end
end

class WisperSymbolSubscriber
  def simple_event(a, b)
    a + b
  end
end

wisper_publisher = WisperPublisher.new
wisper_publisher.subscribe WisperSymbolSubscriber.new
wisper_publisher.emit :simple_event, 1, 2

require_relative '../lib/eventor'

class SimpleEventorSubscriber < Eventor::Subscriber
  on SimpleEvent do |event|
    event.a + event.b
  end
end

eventor_publisher = Eventor::Publisher.new
SimpleEventorSubscriber.new eventor_publisher
eventor_publisher.publish SimpleEvent.new 1, 2


require 'benchmark/ips'

Benchmark.ips do |benchmark|
  benchmark.report('object') {object_publisher.emit(SimpleEvent.new 1, 2) }
  benchmark.report('symbol') {symbol_publisher.emit :simple_event, {a: 1, b: 2} }
  benchmark.report('event_bus') {EventBus.announce :simple_event, a: 1, b: 2 }
  benchmark.report('wisper') {wisper_publisher.emit :simple_event, 1, 2 }
  benchmark.report('eventor') {eventor_publisher.publish SimpleEvent.new 1, 2}
end

