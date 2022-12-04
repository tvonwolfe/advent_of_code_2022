# frozen_string_literal: true

require_relative './rucksack'

items = File
        .readlines('input', chomp: true)
        .map { |line| Rucksack.new(line).common_items_for_compartments.first }

puts items.map { |item| Rucksack::PRIORITIES.index(item) + 1 }.sum.to_s
