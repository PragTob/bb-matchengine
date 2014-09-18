require 'spec_helper'
require_relative './shared_example_action_spec'

describe BBMatchengine::Shot do
  let(:squad1) {SquadFactory.create}
  let(:squad2) {SquadFactory.create 'Blue Dragons'}
  let(:game)   {BBMatchengine::Game.new squad1, squad2}
  let(:action) {described_class.new game}

  it_should_behave_like 'an action'

  describe '#play' do
    let(:good_shooter) {PlayerFactory.create shooting: 100}
    let(:good_defender) {PlayerFactory.create defense: 100}
    let(:bad_shooter) {PlayerFactory.create shooting: 1}
    let(:bad_defender) {PlayerFactory.create defense: 1}

    before :each do
      allow(Kernel).to receive(:rand) {|maximum| maximum / 2}
    end

    it 'lets the good shooter win' do
      allow(action).to receive(:shooter)  { good_shooter }
      allow(action).to receive(:defender) { bad_defender }
      expect { action.play }.to change{game.team_a_score}.by(2)
    end

    it 'lets the bad shooter loose' do
      allow(action).to receive(:shooter)  { bad_shooter }
      allow(action).to receive(:defender) { good_defender }
      expect { action.play }.not_to change{game.team_a_score}
    end
  end
end