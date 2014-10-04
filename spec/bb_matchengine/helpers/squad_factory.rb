module SquadFactory
  extend self

  DEFAULT_TEAM = TeamFactory.create name: 'Red Dragons'

  def create(team = nil, starters = nil, substitutes = nil)
    team        ||= DEFAULT_TEAM
    starters    ||= PlayerFactory.mass_create 5, team: team
    substitutes ||= PlayerFactory.mass_create 7, team: team
    BBMatchengine::Squad.new(team, starters, substitutes)
  end
end