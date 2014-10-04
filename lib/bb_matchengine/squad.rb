module BBMatchengine
  class Squad

    class TooManySubstitutesError < ArgumentError ; end

    attr_reader :team, :lineup, :substitutes
    MAX_SUBSTITUTES      = 7

    def initialize(team, starters, substitutes)
      @team        = team
      @lineup      = Lineup.new starters
      @substitutes = substitutes

      check_squad
    end

    def team_name
      @team.name
    end

    def players
      @lineup.players + @substitutes
    end

    private
    def check_squad
      raise TooManySubstitutesError if @substitutes.size > MAX_SUBSTITUTES
    end
  end
end