module BBMatchengine
  class Game

    # http://en.wikipedia.org/wiki/Basketball#Playing_regulations (EU)
    QUARTER_LENGTH = 10 * 60
    GAME_TIME      = QUARTER_LENGTH * 4

    # Match engine values
    OFFENSIVE_REBOUND_PENALTY = 10

    attr_reader :offense_squad, :defense_squad, :home_squad, :away_squad

    def initialize(home_squad, away_squad)
      @home_squad     = home_squad
      @away_squad     = away_squad
      @offense_squad  = @home_squad # TODO Jumpball
      @defense_squad  = @away_squad
      @score          = {@offense_squad => 0, @defense_squad => 0}
      @current_time   = 0
    end

    def play
      until game_end?
        play_possession
      end
    end

    def play_possession
      active_player  = offense_lineup.sample
      defense_player = defense_lineup.sample
      shot_attempt(active_player, defense_player)
      update_time
    end

    def possession_time
      Kernel.rand(10..24)
    end

    def shot_attempt(shooter, defender)
      if shooter.shoot(defender)
        increase_score(2)
        switch_possession
      else
        rebound
      end
    end

    def rebound
      offense_rebound_score = offense_lineup.rebound / OFFENSIVE_REBOUND_PENALTY
      defense_rebound_score = defense_lineup.rebound
      if Picker.successful? offense_rebound_score, defense_rebound_score
        rebounder = Picker.pick offense_lineup.rebound_probabilities
      else
        rebounder = Picker.pick defense_lineup.rebound_probabilities
        switch_possession
      end
    end

    def increase_score(value)
      @score[@offense_squad] += value
    end

    def home_score
      @score[@home_squad]
    end

    def away_score
      @score[@away_squad]
    end

    private
    def offense_lineup
      @offense_squad.lineup
    end

    def defense_lineup
      @defense_squad.lineup
    end

    def game_end?
      @current_time >= GAME_TIME
    end

    def switch_possession
      @offense_squad, @defense_squad = @defense_squad, @offense_squad
    end

    def update_time
      @current_time += possession_time
    end
  end
end