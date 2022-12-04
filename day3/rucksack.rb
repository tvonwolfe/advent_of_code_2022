# frozen_string_literal: true

class Rucksack
  PRIORITIES = Array('a'..'z') + Array('A'..'Z')

  def initialize(str)
    half = str.length / 2
    @compartment_a = str[0..half]
    @compartment_b = str[half + 1, str.length]
  end

  def common_items
    @common_items ||= PRIORITIES.select do |item|
      compartment_a.include?(item) &&
        compartment_b.include?(item)
    end
  end

  private

  attr_reader :compartment_a, :compartment_b

  def priority(item)
    PRIORITIES.index(item) + 1
  end
end
