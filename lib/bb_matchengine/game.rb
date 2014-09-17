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

    def play_possession
      active_player  = offense_on_court.sample
      defense_player = defense_on_court.sample
      shot_attempt(active_player, defense_player)
      @current_length += possession_time
      switch_possession
    end

    def possession_time
      Kernel.rand(10..24)
    end

    def shot_attempt(shooter, defender)
      @score[@offense_squad] += 2 if shot_made?(defender, shooter)
    end

    def shot_made? defender, shooter
      shooter.offense_potential + Kernel.rand(20) > defender.defense_potential + Kernel.rand(20)
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
    def offense_on_court
      @offense_squad.active_players
    end

    def defense_on_court
      @defense_squad.active_players
    end

    def game_end?
      @current_length >= GAME_TIME
    end

    def switch_possession
      @offense_squad, @defense_squad = @defense_squad, @offense_squad
    end
  end
end