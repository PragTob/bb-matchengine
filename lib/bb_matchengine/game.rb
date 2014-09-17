module BBMatchengine
  class Game

    # http://en.wikipedia.org/wiki/Basketball#Playing_regulations (NBA)
    QUARTER_LENGTH = 12 * 60

    attr_reader :squads, :possessions

    def initialize(squads)
      @squads      = squads
      @possessions = []
    end

    def run
      while current_length < QUARTER_LENGTH * 4
        @possessions << Possession.create(self)
      end
    end

    def current_owner
      # TODO something more meaningful here
      return squads.first if possessions.empty?
      squad = last_possession.is_a?(TurnOver) ? :opponent_squad : :owner_squad
      last_possession.public_send(squad)
    end

    private
    def last_possession
      possessions.last
    end

    def current_length
      possessions.inject(0) { |sum, p| sum + p.length }
    end
  end
end