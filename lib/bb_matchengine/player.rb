module BBMatchengine
  # Rebound
  # Speed
  # Shooting (2p, 3p, close, drive)
  # Dribbling
  # Passing
  # (Athleticism)
  # (height)
  # (weight)
  # (name)
  # (experience)
  # (fatigue)
  class Player
    ATTRIBUTES = [:rebound, :speed]
    attr_reader *ATTRIBUTES

    def initialize(name, attributes)
      @name = name
      attributes.each do |attribute, value|
        instance_variable_set :"@#{attribute}", value
      end
    end
  end
end