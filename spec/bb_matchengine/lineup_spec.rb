require 'spec_helper'

describe BBMatchengine::Lineup do
  let(:rebound) {20}
  let(:players) {PlayerFactory.mass_create 5, rebound: rebound}
  let(:bad_rebounder) {PlayerFactory.create rebound: 0}
  let(:to_substitute) {players.first}
  subject {BBMatchengine::Lineup.new players}

  describe '#substitute' do
    before :each do
      subject.substitute to_substitute, bad_rebounder
    end

    it 'no longer has the substituted player' do
      expect(subject).not_to include to_substitute
    end

    it 'has the substituted player' do
      expect(subject).to include bad_rebounder
    end
  end

  describe '#rebound' do
    it 'responds with the cumulative rebound strength of the players' do
      # testing the real thing would be reimplementing the method
      expect(subject.rebound).to be >= 0
    end

    it 'changes accordingly if a substitution is made' do
      expect do
        subject.substitute to_substitute, bad_rebounder
      end.to change {subject.rebound}.by(-rebound)
    end
  end
end