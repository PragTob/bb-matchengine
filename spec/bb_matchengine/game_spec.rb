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
      end.to change{subject.home_score}.by(2)
    end

    it 'lets the bad shooter loose' do
      expect do
        subject.shot_attempt bad_shooter, good_defender
      end.not_to change{subject.home_score}
    end

    it 'lets a bad shot result in a rebound' do
      allow(subject).to receive(:rebound)
      subject.shot_attempt bad_shooter, good_defender
      expect(subject).to have_received(:rebound)
    end
  end


  describe '#rebound' do
    # TODO: find a better way to influence the outcome
    it 'keeps the possession in case of an offensive rebound' do
      allow(Picker).to receive_messages(successful?: true)
      subject.rebound
      expect(subject.offense_squad).to eq squad1
    end

    it 'switches possession in case of a defensive rebound' do
      allow(Picker).to receive_messages(successful?: false)
      subject.rebound
      expect(subject.offense_squad).to eq squad2
    end

  end

  describe '#play_possessceion' do
    it 'gives the possession to the other team if the player makes the shot' do
      allow_any_instance_of(BBMatchengine::Player).to receive(:shoot).and_return(true)
      subject.play_possession
      expect(subject.offense_squad).to eq squad2
    end
  end
end