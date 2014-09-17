module SquadFactory
  extend self

  SQUAD_DEFAULT_NAME = 'Red Dragons'

  def create(team_name = nil, starters = nil, substitutes = nil)
    team_name   ||= SQUAD_DEFAULT_NAME
    starters    ||= PlayerFactory.mass_create 5
    substitutes ||= PlayerFactory.mass_create 7
    BBMatchengine::Squad.new(team_name, starters, substitutes)
  end
end