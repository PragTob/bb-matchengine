module Picker
  # The hash is of the form {object => probability}
  # The probability should be numbers that relative to each other determine
  # the probability of the object being picked.
  # Example:
  #     Picker.pick a: 10, b: 5, c: 7
  def self.pick(hash)
    value_to_object = {}
    sum_of_values = hash.inject(0) do |sum, (key, value)|
      sum += value
      value_to_object[sum] = key
      sum
    end

    picked_number = Kernel.rand(sum_of_values)

    value_to_object.each do |value, object|
      # remember that it needs to be smaller as Kernel.rand also returns 0
      # but does not return the upper bound passed in
      return object if picked_number < value
    end
  end

  def self.successful?(winning_value, losing_value)
    random_number = Kernel.rand(winning_value + losing_value)
    random_number < winning_value
  end
end