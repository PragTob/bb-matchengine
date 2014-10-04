module BBMatchengine
  module Events
    ShotMade = Struct.new :points, :player, :defender

    class TwoPointShotMade < ShotMade
      def initialize(player, defender)
        super 2, player, defender
      end
    end

    ShotMissed = Struct.new :player, :defender
    class TwoPointShotMissed < ShotMissed
    end
  end
end