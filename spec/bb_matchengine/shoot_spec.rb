require 'spec_helper'

describe BBMatchengine::Shoot do
  let(:squad1) { SquadFactory.create }
  let(:squad2) { SquadFactory.create('Blue Dragons') }
  subject {described_class.new squad1, squad2}
end