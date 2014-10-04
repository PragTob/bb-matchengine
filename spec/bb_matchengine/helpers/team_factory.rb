module TeamFactory
  extend self

  DEFAULT_NAME = 'Red Dragons KW'

  def create(attributes = {})
    BBMatchengine::Team.new attributes[:name] || DEFAULT_NAME
  end
end