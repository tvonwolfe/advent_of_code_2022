# frozen_string_literal: true

require_relative 'rope'

movements = File.readlines('input')
                .map(&:strip)
                .map { |line| line.split(' ') }
                .map { |direction, distance| Rope::Movement.new(direction, distance.to_i) }

rope = Rope.new(Rope::Point.new(0, 0), Rope::Point.new(0, 0))

tail_positions = []
movements.each do |movement|
  tail_positions += rope.move(movement)
end

puts tail_positions.uniq.count
