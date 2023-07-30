# frozen_string_literal: true

require 'byebug'

class Rope
  attr_reader :head, :tail, :knots

  # @param knots [Array<Point>]
  def initialize(*knots)
    @head = knots.first
    @tail = knots.last
    @knots = knots
  end

  # @param movement [Movement]
  def move(movement, tail_positions = [])
    return tail_positions if movement.distance.zero?

    mvmt = movement.clone
    mvmt.distance -= 1

    case mvmt.direction
    when :up
      head.y += 1
    when :down
      head.y -= 1
    when :right
      head.x += 1
    when :left
      head.x -= 1
    end

    tail_positions += adjust_rest!
    move(mvmt, tail_positions)
  end

  Point = Struct.new(:x, :y) do
    def touching?(other)
      return true if other == self

      (other.x - x).abs <= 1 && (other.y - y).abs <= 1
    end

    def ==(other)
      other.x == x && other.y == y
    end

    def to_s
      "(#{x}, #{y})"
    end
  end

  class Movement
    DIRECTIONS = %i[up down left right].freeze

    attr_reader :direction
    attr_accessor :distance

    # @param direction [String, Symbol]
    # @param distance [Integer]
    def initialize(direction, distance)
      @direction = DIRECTIONS.find do |d|
        d.to_s[0] == direction.downcase
      end
      @distance = distance
    end

    def inspect
      "#<Movement @direction=#{direction} @distance=#{distance}>"
    end

    def to_s
      inspect
    end
  end

  private

  def adjust_rest!
    tail_positions = []
    rest = knots[1..]
    rest.each_with_index do |knot, index|
      prev_knot = knots[index]

      unless knot.touching?(prev_knot)

        x_delta = (prev_knot.x - knot.x)
        y_delta = (prev_knot.y - knot.y)

        if x_delta.negative?
          knot.x -= 1
        elsif x_delta.positive?
          knot.x += 1
        end

        if y_delta.negative?
          knot.y -= 1
        elsif y_delta.positive?
          knot.y += 1
        end
      end

      tail_positions << knot.clone if index == rest.count - 1
    end

    tail_positions
  end
end
