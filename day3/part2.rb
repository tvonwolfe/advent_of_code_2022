# frozen_string_literal: true

require_relative './rucksack'
require 'byebug'

rucksack_groups = File
                  .readlines('input', chomp: true)
                  .map { |line| Rucksack.new(line) }
                  .each_slice(3)
                  .to_a

priorities = rucksack_groups
             .map { |rucksack_group| Rucksack.common_item(*rucksack_group) }
             .map { |group_common_item| Rucksack::PRIORITIES.index(group_common_item) + 1 }

puts priorities.sum
