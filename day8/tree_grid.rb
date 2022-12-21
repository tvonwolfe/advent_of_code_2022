# frozen_string_literal: true

# tree grid class
class TreeGrid
  # @param grid [Array<Array>] - 2D grid representing trees and their heights
  def initialize(grid)
    @grid = grid.map.with_index do |row, row_index|
      row.chars.map.with_index do |height, col_index|
        Tree.new(col_index, row_index, height)
      end
    end
  end

  def visible_trees
    grid.map do |row|
      row.select do |tree|
        visible?(tree)
      end
    end.flatten
  end

  def scenic_scores
    grid.map do |row|
      row.map do |tree|
        above, below = trees_in_column(tree).partition do |t|
          t.y < tree.y
        end

        left, right = trees_in_row(tree).partition do |t|
          t.x < tree.x
        end

        [above.reverse, below, left.reverse, right]
          .map { |direction| view_distance(tree, direction) }
          .reduce(:*)
      end
    end.flatten
  end

  private

  attr_reader :grid

  def view_distance(tree, direction)
    return 0 if perimeter?(tree)

    distance = direction.index { |t| t.height >= tree.height } || direction.length - 1
    distance + 1
  end

  # @param tree [Tree] - input tree
  def visible?(tree)
    return true if perimeter?(tree)

    above, below = trees_in_column(tree).partition do |t|
      t.y < tree.y
    end

    left, right = trees_in_row(tree).partition do |t|
      t.x < tree.x
    end

    [above, below, left, right].any? do |direction|
      tallest?(tree, direction)
    end
  end

  # @param tree [Tree] - input tree
  def tallest?(tree, other_trees)
    other_trees.all? do |other_tree|
      other_tree.height < tree.height
    end
  end

  # @param tree [Tree] - input tree
  def trees_in_column(tree)
    grid.map do |row|
      row.select { |other_tree| other_tree.x == tree.x && other_tree.y != tree.y }
    end.flatten
  end

  # @param tree [Tree] - input tree
  def trees_in_row(tree)
    grid[tree.y].reject { |other_tree| other_tree.x == tree.x }
  end

  # @param tree [Tree] - input tree
  def perimeter?(tree)
    tree.x.zero? ||
      tree.y.zero? ||
      tree.x == grid.first.length - 1 ||
      tree.y == grid.length - 1
  end

  # tree class
  Tree = Struct.new(:x, :y, :height)
end
