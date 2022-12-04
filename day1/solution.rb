# frozen_string_literal: true

lines = File.readlines('input', chomp: true)

elves = []
current_elf_index = 0

lines.each do |line|
  next current_elf_index += 1 if line.empty?

  calories = line.to_i

  if elves[current_elf_index].nil?
    elves[current_elf_index] = calories
  else
    elves[current_elf_index] += calories
  end
end

elves.sort!

puts "#{elves.last}"
puts "#{elves.last(3).sum}"
