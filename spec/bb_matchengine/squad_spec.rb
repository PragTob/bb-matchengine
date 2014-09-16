require 'spec_helper'

describe BBMatchengine::Squad do

  let(:name) {'Red Dragons'}
  let(:starters) {[PlayerFactory.create]}
  let(:substitutes) {[]}

  subject {described_class.new name, starters, substitutes}

  it 'has the right name' do
    expect(subject.team_name).to eq (name)
  end
end