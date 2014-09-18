module BBMatchengine
  class Shot < Action

    def play
      @game.increase_score(2) if shot_made?
    end

    def shooter
      @shooter ||= @game.offense_squad.active_players.sample
    end

    def defender
      @shooter ||= @game.defense_squad.active_players.sample
    end

    def shot_made?
      shooter.offense_potential + Kernel.rand(20) > defender.defense_potential + Kernel.rand(20)
    end
  end
end