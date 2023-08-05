# frozen_string_literal: true

require_relative 'cpu'
require 'byebug'

cpu = Cpu.init(File.readlines('input'))

checkpoints = [1, 3, 5, 7, 9, 11].map { |i| i * 20 }
results = []
until cpu.complete?
  cpu.tick
  index = checkpoints.find_index(cpu.cycle_counter)

  results << checkpoints[index] * cpu.register unless index.nil?
end

puts results.sum
