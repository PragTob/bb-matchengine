require 'spec_helper'

describe BBMatchengine::Player do
  ATTRIBUTES = BBMatchengine::Player::ATTRIBUTES

  subject {PlayerFactory.create}

  ATTRIBUTES.each do |attribute|
    it "sets and reads #{attribute} correctly" do
      expect(subject.public_send attribute).to eq PlayerFactory::DEFAULT_ATTRIBUTES[attribute]
    end
  end

  describe 'missing an attribute' do
    let(:missing_hash) do
      hash = PlayerFactory::DEFAULT_ATTRIBUTES
      hash.reject{ |key, value| key == :rebound}
    end

    it 'raises an error noting the missing rebound' do
      expect do
        described_class.new 'dummy', missing_hash
      end.to raise_error BBMatchengine::Player::MissingAttributeError, /rebound/
    end
  end
end