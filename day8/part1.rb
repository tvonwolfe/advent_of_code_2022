# frozen_string_literal: true

require_relative 'tree_grid'

grid = File.readlines('input', chomp: true)

tree_grid = TreeGrid.new(grid)

puts tree_grid.visible_trees.count
