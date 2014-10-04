require 'spec_helper'

describe BBMatchengine::Team do
  let(:name) {'Red Dragons KW'}
  subject {BBMatchengine::Team.new name}

  it 'has the set name' do
    expect(subject.name).to eq name
  end
end