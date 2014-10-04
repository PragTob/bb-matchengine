module PlayerFactory
  extend self

  ATTRIBUTES = BBMatchengine::Player::ATTRIBUTES
  DEFAULT = 10
  DEFAULT_ATTRIBUTES = ATTRIBUTES.each_with_index.inject({}) do |hash, (attribute, i)|
    hash[attribute] = DEFAULT + i
    hash
  end

  DEFAULT_NAME = 'Bob'
  DEFAULT_TEAM = TeamFactory.create

  def create(attributes = {})
    player_attributes = DEFAULT_ATTRIBUTES.merge attributes
    BBMatchengine::Player.new((attributes[:name] || DEFAULT_NAME),
                               attributes[:team] || DEFAULT_TEAM,
                               player_attributes)
  end

  def mass_create(amount, attributes = {})
    (1..amount).map{create attributes}
  end
end