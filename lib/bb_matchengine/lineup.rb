module BBMatchengine
  class Lineup

    class WrongNumberOfPlayers < ArgumentError
      def message
        "There have to be #{PLAYERS_COUNT} ready to play."
      end
    end

    PLAYERS_COUNT = 5

    attr_reader :players

    def initialize(players)
      @players = players
      check_lineup
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

    def sample
      @players.sample
    end

    def to_a
      @players
    end

    private
    def check_lineup
      raise WrongNumberOfPlayers if @players.size != PLAYERS_COUNT
    end
  end
end