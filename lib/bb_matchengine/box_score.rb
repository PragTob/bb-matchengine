module BBMatchengine
  class BoxScore < Eventor::Subscriber

    def initialize(publisher, home_squad, away_squad)
      @home_squad = home_squad
      @away_squad  = away_squad
      initialize_box_score home_squad, away_squad
      super publisher
    end

    on Events::TwoPointShotMade do |event|
      increase_stat(event.player, :points, 2)
    end

    def for(entity)
      @box_score[entity]
    end

    private
    def initialize_box_score(squad_a, squad_b)
      @box_score        = initial_box_score squad_a.players + squad_b.players +
                                            [squad_a.team, squad_b.team]
    end

    def initial_box_score(entries)
      box_score = {}
      entries.each {|entry| box_score[entry] = initial_stats}
      box_score
    end

    def initial_stats
      {points: 0}
    end

    def increase_stat(player, stat, value)
      @box_score[player][stat]      += value
      @box_score[player.team][stat] += value
    end
  end
end