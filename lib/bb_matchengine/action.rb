module BBMatchengine
  class Action

    def initialize(game)
      @game = game
    end

    def play
      raise "not implemented"
    end

    def time
      # Probably different per action
      Kernel.rand(10..24)
    end

  end
end