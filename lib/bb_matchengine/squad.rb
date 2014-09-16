module BBMatchengine
  class Squad

    attr_reader :team_name

    def initialize(team_name, starters, substitutes)
      @team_name      = team_name
      @active_players = starters
      @substitutes    = substitutes
    end
  end
end