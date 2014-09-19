require 'bb_matchengine'
require_relative '../spec/bb_matchengine/helpers/player_factory'
require_relative '../spec/bb_matchengine/helpers/squad_factory'
require 'benchmark/ips'


Benchmark.ips do |benchmark|

  benchmark.config(warmup: 10, time: 20)

  squad_1 = SquadFactory.create
  squad_2 = SquadFactory.create
  game = BBMatchengine::Game.new squad_1, squad_2

  benchmark.report('game') {BBMatchengine::Game.new(squad_1, squad_2).play}
end