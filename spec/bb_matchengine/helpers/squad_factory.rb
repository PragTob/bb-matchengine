module SquadFactory
  extend self

  SQUAD_DEFAULT_NAME = 'Red Dragons'

  def create(team_name = nil, starters = nil, substitutes = nil)
    team_name   ||= SQUAD_DEFAULT_NAME
    starters    ||= [0..4].map { PlayerFactory.create }
    substitutes ||= [0..7].map { PlayerFactory.create }
    BBMatchengine::Squad.new(team_name, starters, substitutes)
  end
end