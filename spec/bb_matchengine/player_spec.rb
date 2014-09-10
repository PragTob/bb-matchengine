require 'spec_helper'

describe BBMatchengine::Player do
  ATTRIBUTES = BBMatchengine::Player::ATTRIBUTES

  ATTRIBUTES.each_with_index do |attribute, i|
    let(attribute) {10 + i}
  end

  let(:player_attributes) do
    ATTRIBUTES.inject({}) do |hash, attribute|
      hash[attribute] = send attribute
      hash
    end
  end

  subject {described_class.new 'Fury', player_attributes}

  ATTRIBUTES.each do |attribute|
    it "sets and reads #{attribute} correctly" do
      expect(subject.public_send attribute).to eq send attribute
    end
  end

  describe 'missing an attribute' do
    let(:missing_hash) do
      hash = player_attributes
      hash.delete :rebound
      hash
    end

    it 'raises an error noting the missing rebound' do
      expect do
        described_class.new 'dummy', missing_hash
      end.to raise_error BBMatchengine::Player::MissingAttributeError, /rebound/
    end
  end
end