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
end