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
    ATTRIBUTES = [:rebound, :speed, :shooting, :defense]
    attr_reader *ATTRIBUTES

    class MissingAttributeError < ArgumentError
      def initialize(missing_attributes)
        @missing_attributes = missing_attributes
      end

      def message
        "Missing the following attributes: #{@missing_attributes.join(',')}"
      end
    end

    def initialize(name, attributes)
      @name = name
      check_for_missing_attribute attributes
      ATTRIBUTES.each do |attribute|
        instance_variable_set :"@#{attribute}", attributes[attribute]
      end
    end

    def offense_potential
      0.5 * speed + shooting
    end

    def defense_potential
      0.5 * speed + defense
    end

    private
    def check_for_missing_attribute(attributes)
      missing_attributes = ATTRIBUTES - attributes.keys
      unless missing_attributes.empty?
        raise MissingAttributeError.new(missing_attributes) 
      end
    end
  end
end