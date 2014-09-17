module BBMatchengine
  class Squad

    attr_reader :team_name, :active_players, :substitutes
    ACTIVE_PLAYERS_COUNT = 5
    MAX_SUBSTITUTES      = 7

    class WrongNumberOfActivePlayers < ArgumentError
      def message
        "There have to be #{ACTIVE_PLAYERS_COUNT} ready to play."
      end
    end
    class TooManySubstitutesError < ArgumentError ; end

    def initialize(team_name, starters, substitutes)
      @team_name      = team_name
      @active_players = starters
      @substitutes    = substitutes

      check_squad
    end

    private
    def check_squad
      raise WrongNumberOfActivePlayers if active_players.size != ACTIVE_PLAYERS_COUNT
      raise TooManySubstitutesError if @substitutes.size > MAX_SUBSTITUTES
    end
  end
end