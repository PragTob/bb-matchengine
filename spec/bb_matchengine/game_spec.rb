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

  describe '#shot_attempt' do
    let(:good_shooter) {PlayerFactory.create shooting: 100}
    let(:good_defender) {PlayerFactory.create defense: 100}
    let(:bad_shooter) {PlayerFactory.create shooting: 1}
    let(:bad_defender) {PlayerFactory.create defense: 1}

    before :each do
      allow(Kernel).to receive(:rand) {|maximum| maximum / 2}
    end

    it 'lets the good shooter win' do
      expect do
        subject.shot_attempt good_shooter, bad_defender
      end.to change{subject.team_a_score}.by(2)
    end

    it 'lets the bad shooter loose' do
      expect do
        subject.shot_attempt bad_shooter, good_defender
      end.not_to change{subject.team_a_score}
    end
  end

  describe '#play_possession' do
    it 'gives the possession to the other team' do
      subject.play_possession
      expect(subject.offense_squad).to eq squad2
    end
  end
end