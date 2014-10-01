module Eventor
  class Publisher
    def initialize
      @event_to_subscribers = Hash.new {|hash, key| hash[key] = []}
    end

    def subscribe(event, subscriber, action)
      @event_to_subscribers[event] ||= []
      @event_to_subscribers[event] << [subscriber, action]
    end

    def publish(event)
      @event_to_subscribers[event.class].each do |subscriber, block|
        subscriber.instance_exec(event, &block)
      end
    end
  end
end