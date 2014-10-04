module SquadFactory
  extend self

  RED_DRAGONS = TeamFactory.create name: 'Red Dragons'
  BLUE_WEASELS = TeamFactory.create name: 'Blue Weasels'
  DEFAULT_TEAM = RED_DRAGONS


  def red_dragons
    create RED_DRAGONS
  end

  def blue_weasels
    create BLUE_WEASELS
  end

  def create(team = nil, starters = nil, substitutes = nil)
    team        ||= DEFAULT_TEAM
    starters    ||= PlayerFactory.mass_create 5, team: team
    substitutes ||= PlayerFactory.mass_create 7, team: team
    BBMatchengine::Squad.new(team, starters, substitutes)
  end
end