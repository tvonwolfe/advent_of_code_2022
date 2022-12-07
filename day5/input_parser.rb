# frozen_string_literal: true

require_relative 'crate_stack_manager'

# input parser
class InputParser
  class << self
    # @param str [String] - input string representing crate stacks
    def parse_stack_string(str)
      stacks = []
      lines = str.split("\n")
      stack_numbers_line = lines.pop

      (0..lines.map(&:length).max).each do |col_nr|
        next if stack_numbers_line[col_nr].nil?
        next unless stack_numbers_line[col_nr].match?(/[0-9]+/)

        stack = []
        (lines.count - 1).downto(0).each do |line_nr|
          crate = lines[line_nr][col_nr]
          break if crate.nil?
          break unless crate.match?(/[A-Z]+/)

          stack.push(crate)
        end
        stacks.push(stack)
      end
      stacks
    end

    # @param str [String] - input string representing instruction
    # @return [Array<CrateStackManager::CrateMovement>] - instructions
    def parse_instructions_string(str)
      str.split("\n").map do |line|
        match_data = line.match(/move (\d+) from (\d+) to (\d+)/)
        nums = match_data.to_a.last(3).map(&:to_i)
        CrateStackManager::CrateMovement.new(*nums)
      end
    end
  end
end
