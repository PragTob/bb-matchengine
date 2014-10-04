require 'spec_helper'

describe BBMatchengine::Squad do

  let(:team_name) {'Red Dragons'}
  let(:team) {TeamFactory.create name: team_name}
  let(:starters) {PlayerFactory.mass_create 5}
  let(:substitutes) {PlayerFactory.mass_create 7}

  subject {described_class.new team, starters, substitutes}

  it 'has the right name' do
    expect(subject.team_name).to eq (team_name)
  end

  it 'has the right team' do
    expect(subject.team).to eq team
  end

  it 'has the starters as active players' do
    expect(subject.lineup.to_a).to eq starters
  end

  it 'has the substitutes' do
    expect(subject.substitutes).to eq substitutes
  end

  it 'can access all the players' do
    expect(subject.players).to match_array starters + substitutes
  end

  describe 'errors' do

    describe 'one starter too few' do
      let(:starters) {PlayerFactory.mass_create 4}

      it 'raises an error' do
        expect {subject}.to raise_error BBMatchengine::Lineup::WrongNumberOfPlayers
      end
    end

    describe 'one starter too much' do
      let(:starters) {PlayerFactory.mass_create 6}

      it 'raises an error' do
        expect {subject}.to raise_error BBMatchengine::Lineup::WrongNumberOfPlayers
      end
    end

    describe 'too many substitutes' do
      let(:substitutes) {PlayerFactory.mass_create 8}

      it 'raises an error' do
        expect {subject}.to raise_error BBMatchengine::Squad::TooManySubstitutesError
      end
    end

  end
end