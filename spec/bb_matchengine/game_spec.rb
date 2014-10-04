require 'spec_helper'

describe BBMatchengine::Game do
  let(:squad1) {SquadFactory.create}
  let(:squad2) {SquadFactory.create TeamFactory.create name: 'Blue Dragons'}
  subject {described_class.new(squad1, squad2)}

  def expect_to_publish_event(event)
    expect(subject).to receive(:publish_event).with event
  end

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
    let(:shooter) {squad1.lineup.sample}
    let(:defender) {squad2.lineup.sample}

    describe 'successful shot' do

      before :each do
        allow(Picker).to receive_messages(successful?: true)
      end

      it 'emits two point shot made for a successful shot' do
        expect_to_publish_event BBMatchengine::Events::TwoPointShotMade.new shooter, defender
        subject.shot_attempt shooter, defender
      end

      it 'changes the score' do
        expect do
          subject.shot_attempt shooter, defender
        end.to change {subject.home_score}.by(2)
      end
    end


    describe 'shot missed' do

      before :each do
        allow(Picker).to receive_messages(successful?: false)
      end

      it 'emits a shot missed event' do
        expect_to_publish_event BBMatchengine::Events::TwoPointShotMissed.new shooter, defender
        subject.shot_attempt shooter, defender
      end

      it 'lets a missed shot result in a rebound' do
        allow(subject).to receive(:rebound)
        subject.shot_attempt shooter, defender
        expect(subject).to have_received(:rebound)
      end

      it 'does not change the score' do
        expect do
          subject.shot_attempt shooter, defender
        end.not_to change {subject.home_score}
      end
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