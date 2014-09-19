require 'bb_matchengine'
require_relative '../../spec/bb_matchengine/helpers/player_factory'
require_relative '../../spec/bb_matchengine/helpers/squad_factory'

desc 'Simulate a dummy game'
task :simulate_game, [:number] do |task, args|
  number = args[:number].to_i || 1
  squad_1 = SquadFactory.create
  squad_2 = SquadFactory.create

  number.times do
    game = BBMatchengine::Game.new squad_1, squad_2
    game.play
    puts "#{game.team_a_score}:#{game.team_b_score}"
  end
end
