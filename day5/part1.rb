# frozen_string_literal: true

require_relative 'input_parser'

file_str = File.read('input')
stacks_str, instructions_str = file_str.split("\n\n")

stacks = InputParser.parse_stack_string(stacks_str)
instructions = InputParser.parse_instructions_string(instructions_str)

csm = CrateStackManager.new(*stacks)

instructions.each do |inst|
  csm.handle_movement(inst)
end

puts csm.peek.join
