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

  describe '#offense_potential' do
    let(:superior_player) {PlayerFactory.create shooting: 50}

    it 'is a positive number' do
      expect(subject.offense_potential).to be >= 0
    end

    it 'is bigger for a player with more shooting ability' do
      expect(superior_player.offense_potential).to be >= subject.offense_potential
    end
  end

  describe '#defense_potential' do
    let(:superior_player) {PlayerFactory.create defense: 50}

    it 'is a positive number' do
      expect(subject.defense_potential).to be >= 0
    end

    it 'is bigger for a player with more shooting ability' do
      expect(superior_player.defense_potential).to be >= subject.defense_potential
    end
  end
end