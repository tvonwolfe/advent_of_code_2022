# frozen_string_literal: true

# represents a Elf's rucksack
class Rucksack
  PRIORITIES = (Array('a'..'z') + Array('A'..'Z')).freeze

  # @param rucksacks [Array<Rucksack>]
  # @return [String] - common item type between all given rucksacks
  def self.common_item(*rucksacks)
    PRIORITIES.find do |item_type|
      rucksacks.all? { |rucksack| rucksack.item?(item_type) }
    end
  end

  def initialize(str)
    @items = str
  end

  def item?(item_type)
    items.include?(item_type)
  end

  def common_items_for_compartments
    @common_items_for_compartments ||= PRIORITIES.select do |item|
      compartment_a.include?(item) &&
        compartment_b.include?(item)
    end
  end

  private

  attr_reader :items

  def compartment_a
    @compartment_a ||= items[0..((items.length / 2) - 1)]
  end

  def compartment_b
    @compartment_b ||= items[(items.length / 2)..items.length]
  end

  def priority(item)
    PRIORITIES.index(item) + 1
  end
end
