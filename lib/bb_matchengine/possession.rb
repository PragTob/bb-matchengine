module BBMatchengine
  class Possession

    attr_reader :length, :owner_squad, :opponent_squad

    def initialize(owner_squad, opponent_squad)
      @owner_squad    = owner_squad
      @opponent_squad = opponent_squad
       # TODO replace with something meaningful
      @length         = 1
    end

    def self.create(game)
      owner_squad       = game.current_owner
      possession_class  = get_possession_type(game)
      possession_class.new owner_squad, (game.squads - [owner_squad]).first
    end

    def self.get_possession_type(game)
      # TODO replace with something meaningful
      Kernel.rand(2) == 1 ? Shoot : TurnOver
    end
  end
end