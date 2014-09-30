module BBMatchengine
  class Lineup
    def initialize(players)
      @players = players
    end

    def rebound
      @players.inject(0) {|sum, player| sum + player.rebound}
    end

    def substitute(player, substitute)
      @players.delete player
      @players << substitute
    end

    def include?(player)
      @players.include? player
    end

    def rebound_probabilities
      @players.inject({}) do |hash, player|
        hash[player] = player.rebound
        hash
      end
    end
  end
end