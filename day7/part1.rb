# frozen_string_literal: true

require_relative 'input_parser'
require_relative 'file_system'

file_tree = File.open('input') do |file|
  InputParser.build_file_tree(file)
end

puts file_tree.directory_sizes.select { |size| size <= 100_000 }.sum
