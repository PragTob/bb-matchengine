require 'spec_helper'

describe BBMatchengine::Game do
  let(:squad1) {SquadFactory.create}
  let(:squad2) {SquadFactory.create 'Blue Dragons'}
  subject {described_class.new [squad1, squad2]}

  it 'has the given squads' do
    expect(subject.squads).to eq([squad1, squad2])
  end

  it 'has no possessions on initialization' do
    expect(subject.possessions).to eq([])
  end

  it 'runs the game as long as the current_length is smaller than the overall length' do
    allow_any_instance_of(BBMatchengine::Possession).to receive(:length).and_return(BBMatchengine::Game::QUARTER_LENGTH)
    subject.run
    expect(subject.possessions.size).to eq(4)
  end

  it 'has the first squad as the current owner in first possession' do
    expect(subject.current_owner).to eq(squad1)
  end

  it 'has the last owner squad as the current owner' do
    allow(subject).to receive(:possessions) {[BBMatchengine::Possession.new(squad2, squad1)]}
    expect(subject.current_owner).to eq(squad2)
  end

  it 'has the last opponent squad as the current owner if a turn over happened' do
    allow(subject).to receive(:possessions) {[BBMatchengine::TurnOver.new(squad2, squad1)]}
    expect(subject.current_owner).to eq(squad1)
  end
end