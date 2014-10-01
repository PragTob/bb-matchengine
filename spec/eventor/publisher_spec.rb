require 'spec_helper'

describe Eventor::Publisher do
  subject {Eventor::Publisher.new}

  class TestEventClass
  end

  class OtherEventClass
  end

  let(:subscriber) {double 'subscriber', call_me: true}

  before :each do
    proc = proc {call_me}
    subject.subscribe(TestEventClass, subscriber, proc)
  end

  it 'handles subscriptions of clients who excute blocks in their context' do
    subject.publish TestEventClass.new
    expect(subscriber).to have_received :call_me
  end

  it 'does not call the the non subscribers' do
    subject.publish OtherEventClass.new
    expect(subscriber).not_to have_received :call_me
  end
end