module BBMatchengine
  class Game

    # http://en.wikipedia.org/wiki/Basketball#Playing_regulations (EU)
    QUARTER_LENGTH = 10 * 60

    attr_reader :squads, :possessions

    def initialize(squads)
      @squads         = squads
      @possessions    = []
      @current_length = 0
    end

    def run
      while @current_length < QUARTER_LENGTH * 4
        @possessions << Possession.create(self)
        @current_length += last_possession.length
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
  end
end