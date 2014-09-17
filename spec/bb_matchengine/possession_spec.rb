require 'spec_helper'

describe BBMatchengine::Possession do
  let(:squad1) { SquadFactory.create }
  let(:squad2) { SquadFactory.create('Blue Dragons') }
  subject {described_class.new squad1, squad2}

  it 'has the given owner_squad' do
    expect(subject.owner_squad).to eq(squad1)
  end

  it 'has the given opponent_squad' do
    expect(subject.opponent_squad).to eq(squad2)
  end

  it 'creates a possession with current_owner from game' do
    game    = double("game", squads: [squad1, squad2], current_owner: squad1)
    subject = described_class.create(game)
    expect(subject.owner_squad).to    eq(squad1)
    expect(subject.opponent_squad).to eq(squad2)
  end

  it 'creates a possession that is instance of possession type' do
    game    = double("game", squads: [squad1, squad2], current_owner: squad1)
    allow(described_class).to receive(:get_possession_type).with(game) { BBMatchengine::TurnOver }
    subject = described_class.create(game)
    expect(subject).to be_instance_of(BBMatchengine::TurnOver)
  end

  it 'has possession type shoot if rand is 1' do
    game = double("game")
    allow(Kernel).to receive(:rand).with(2).and_return(1)
    expect(described_class.get_possession_type(game)).to eq(BBMatchengine::Shoot)
  end

  it 'has possession type turn over if rand is 0' do
    game = double("game")
    allow(Kernel).to receive(:rand).with(2).and_return(0)
    expect(described_class.get_possession_type(game)).to eq(BBMatchengine::TurnOver)
  end
end