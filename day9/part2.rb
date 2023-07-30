# frozen_string_literal: true

require_relative 'rope'

movements = File.readlines('input')
                .map(&:strip)
                .map { |line| line.split(' ') }
                .map { |direction, distance| Rope::Movement.new(direction, distance.to_i) }

all_knots = 10.times.map { Rope::Point.new(0, 0) }
rope = Rope.new(*all_knots)

tail_positions = []
movements.each do |movement|
  tail_positions += rope.move(movement)
end

puts tail_positions.uniq.count
