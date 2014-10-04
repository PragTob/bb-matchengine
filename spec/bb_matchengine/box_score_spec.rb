require 'spec_helper'

describe BBMatchengine::BoxScore do
  let(:squad_a) {SquadFactory.red_dragons}
  let(:squad_b) {SquadFactory.blue_weasels}
  let(:publisher) {Eventor::Publisher.new}
  let(:player) {squad_a.lineup.sample}
  let(:defender) {squad_b.lineup.sample}
  let(:event) {described_class.new player, defender}

  subject {BBMatchengine::BoxScore.new publisher, squad_a, squad_b}

  def expect_box_change_for(repetition = 1, entity, stat, value)
    expect do
      repetition.times {publisher.publish event}
    end.to change{subject.for(entity)[stat]}.by(value)
  end

  def expect_stat_change(repetition = 1, player, stat, value)
    expect_box_change_for repetition, player, stat, value
    expect_box_change_for repetition, player.team, stat, value
  end

  describe 'initialization' do
    it 'initializes entities with 0 points' do
      expect(subject.for(player)[:points]).to eq 0
    end
  end

  describe BBMatchengine::Events::TwoPointShotMade do
    it 'increases the score' do
      expect_stat_change player, :points, 2
    end

    it 'increases the score multiple times' do
      expect_stat_change 6, player, :points, 12
    end

    it 'increases field_goals_attempted' do
      expect_stat_change player, :field_goals_attempted, 1
    end

    it 'increases field_goals_mad' do
      expect_stat_change player, :field_goals_made, 1
    end
  end

  describe BBMatchengine::Events::TwoPointShotMissed do
    it 'does not increase the score' do
      expect_stat_change player, :points, 0
    end

    it 'does increase the field_goals_attempted' do
      expect_stat_change player, :field_goals_attempted, 1
    end
  end
end