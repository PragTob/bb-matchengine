require 'spec_helper'

describe Eventor::Subscriber do

  class SimpleTestEvent
  end

  class OtherEvent
  end

  class TestSubscriber < Eventor::Subscriber
    on SimpleTestEvent do  end

    on OtherEvent do end
  end

  let(:subscriber_class) do
    Class.new(Eventor::Subscriber) do
      on SimpleTestEvent do  end

      on OtherEvent do end
    end
  end

  let(:subscriber_instance) {subscriber_class.new publisher}

  let(:publisher) {double 'publisher', subscribe: true}

  it 'subscribes to the events on instantiation' do
    instance = subscriber_instance
    expect(publisher).to have_received(:subscribe).with(SimpleTestEvent, instance, anything)
    expect(publisher).to have_received(:subscribe).with(OtherEvent, instance, anything)
  end

end