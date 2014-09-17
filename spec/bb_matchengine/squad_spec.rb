require 'spec_helper'

describe BBMatchengine::Squad do

  let(:name) {'Red Dragons'}
  let(:starters) {PlayerFactory.mass_create 5}
  let(:substitutes) {PlayerFactory.mass_create 7}

  subject {described_class.new name, starters, substitutes}

  it 'has the right name' do
    expect(subject.team_name).to eq (name)
  end

  it 'has the starters as active players' do
    expect(subject.active_players).to eq starters
  end

  it 'has the substitutes' do
    expect(subject.substitutes).to eq substitutes
  end

  describe 'one starter too few' do
    let(:starters) {PlayerFactory.mass_create 4}

    it 'raises an error' do
      expect {subject}.to raise_error BBMatchengine::Squad::WrongNumberOfActivePlayers
    end
  end

  describe 'one starter too much' do
    let(:starters) {PlayerFactory.mass_create 6}

    it 'raises an error' do
      expect {subject}.to raise_error BBMatchengine::Squad::WrongNumberOfActivePlayers
    end
  end

  describe 'too many substitutes' do
    let(:substitutes) {PlayerFactory.mass_create 8}

    it 'raises an error' do
      expect {subject}.to raise_error BBMatchengine::Squad::TooManySubstitutesError
    end

  end
end