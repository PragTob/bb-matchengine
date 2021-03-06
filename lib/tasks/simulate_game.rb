require 'bb_matchengine'
require_relative '../../spec/bb_matchengine/helpers/all'

desc 'Simulate a dummy game'
task :simulate_game, [:number] do |task, args|
  number = args[:number].to_i || 1
  squad_1 = SquadFactory.create
  squad_2 = SquadFactory.create TeamFactory.create name: 'Blue Dragons'

  home_total_score = 0
  away_total_score = 0

  number.times do
    game = BBMatchengine::Game.new squad_1, squad_2
    game.play
    home_total_score += game.home_score
    away_total_score += game.away_score
    puts "#{game.home_score}:#{game.away_score}"
  end

  puts "Average score: #{home_total_score.to_f/number}:#{away_total_score.to_f/number}"
end
