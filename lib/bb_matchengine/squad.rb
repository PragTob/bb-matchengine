module BBMatchengine
  class Squad

    class TooManySubstitutesError < ArgumentError ; end

    attr_reader :team_name, :lineup, :substitutes
    MAX_SUBSTITUTES      = 7

    def initialize(team_name, starters, substitutes)
      @team_name      = team_name
      @lineup         = Lineup.new starters
      @substitutes    = substitutes

      check_squad
    end

    private
    def check_squad
      raise TooManySubstitutesError if @substitutes.size > MAX_SUBSTITUTES
    end
  end
end