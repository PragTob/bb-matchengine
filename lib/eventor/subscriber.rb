module Eventor
  class Subscriber
    def initialize(publisher)
      @publisher = publisher
      execute_on_subscribes
    end

    def subscribe(event_class, blk)
      @publisher.subscribe event_class, self, blk
    end

    def self.on(event_class, &blk)
      @subscribes ||= []
      @subscribes << [event_class, blk]
    end

    def self.subscribes
      @subscribes
    end

    private
    def execute_on_subscribes
      self.class.subscribes.each do |event_class, blk|
        subscribe event_class, blk
      end
    end
  end
end