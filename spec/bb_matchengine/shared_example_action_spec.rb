require 'spec_helper'

shared_examples_for 'an action' do
  describe '#play' do
    it { expect(action).to respond_to(:play) }
    it { expect{ action.play }.to_not raise_error }
  end

  describe '#time' do
    it { expect(action.time).to be_an(Integer) }
  end
end