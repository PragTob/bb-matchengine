module Eventor
  class Publisher
    def initialize
      @event_to_subscribers = Hash.new []
    end

    def subscribe(event, subscriber, action)
      @event_to_subscribers[event] << [subscriber, action]
    end

    def emit(event)
      @event_to_subscribers[event.class].each do |subscriber, block|
        subscriber.instance_exec(event, &block)
      end
    end
  end
end