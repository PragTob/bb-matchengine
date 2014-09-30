module PlayerFactory
  extend self

  ATTRIBUTES = BBMatchengine::Player::ATTRIBUTES
  DEFAULT = 10
  DEFAULT_ATTRIBUTES = ATTRIBUTES.each_with_index.inject({}) do |hash, (attribute, i)|
    hash[attribute] = DEFAULT + i
    hash
  end

  PLAYER_DEFAULT_NAME = 'Bob'

  def create(attributes = {})
    player_attributes = DEFAULT_ATTRIBUTES.merge attributes
    BBMatchengine::Player.new((attributes[:name] || PLAYER_DEFAULT_NAME),                                          player_attributes)
  end

  def mass_create(amount, attributes = {})
    (1..amount).map{create attributes}
  end
end