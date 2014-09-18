module BBMatchengine
  class Game

    # http://en.wikipedia.org/wiki/Basketball#Playing_regulations (EU)
    QUARTER_LENGTH = 10 * 60
    GAME_TIME      = QUARTER_LENGTH * 4

    attr_reader :offense_squad, :defense_squad, :home_squad, :away_squad

    def initialize(home_squad, away_squad)
      @home_squad     = home_squad
      @away_squad     = away_squad
      @offense_squad  = @home_squad # TODO Jumpball
      @defense_squad  = @away_squad
      @score          = {@offense_squad => 0, @defense_squad => 0}
      @current_length = 0
    end

    def play
      until game_end?
        play_possession
      end
    end

    def play_action
      action = next_action.new(game)
      action.play
      @current_length += action.time
    end

    def play_possession
      until possession_end?
        play_action
      end
      switch_possession
    end

    def increase_score(points)
      @score[@offense_squad] += points
    end

    def team_a_score
      @score[@home_squad]
    end

    def team_b_score
      @score[@away_squad]
    end

    # def current_owner
    #   # TODO something more meaningful here
    #   return squads.first if possessions.empty?
    #   squad = last_possession.is_a?(TurnOver) ? :opponent_squad : :owner_squad
    #   last_possession.public_send(squad)
    # end

    private
    def next_action
      Shot
    end

    def game_end?
      @current_length >= GAME_TIME
    end

    def possession_end?
      Kernel.rand(0..1) == 1
    end

    def switch_possession
      @offense_squad, @defense_squad = @defense_squad, @offense_squad
    end
  end
end