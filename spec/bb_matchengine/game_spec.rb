require 'spec_helper'

describe BBMatchengine::Game do
  let(:squad1) {SquadFactory.create}
  let(:squad2) {SquadFactory.create 'Blue Dragons'}
  subject {described_class.new squad1, squad2}

  it 'has the given squads' do
    expect(subject.home_squad).to eq(squad1)
    expect(subject.away_squad).to eq(squad2)
  end

  it 'has the first squad as the offense squad' do
    expect(subject.offense_squad).to eq(squad1)
  end

  it 'has the other squad set at the defensive end' do
    expect(subject.defense_squad).to eq(squad2)
  end

  describe '#play_possession' do
    it 'gives the possession to the other team' do
      subject.play_possession
      expect(subject.offense_squad).to eq squad2
    end
  end
end