# frozen_string_literal: true

require_relative './file_system'

# input parser class
class InputParser
  # @param input_file [File] - input file
  # @return [FileSystem] - file tree structure
  def self.build_file_tree(input_file)
    new(*input_file.readlines(chomp: true)).parse_into_file_tree
  end

  def initialize(*lines)
    @lines = lines
    @file_system = FileSystem.new
  end

  # @return [FileSystem]
  def parse_into_file_tree
    current_line_index = 0
    while current_line_index < lines.length
      current_line = lines[current_line_index]
      break if current_line.nil?
      next unless current_line.start_with?('$')

      _, command, arg = current_line.match(/\$ (\w+)\s*(.*)/).to_a
      current_line_index = case command.to_sym
                           when :cd
                             handle_cd_command(arg)
                             current_line_index + 1
                           when :ls
                             # find the next line that's a command input
                             next_command_input_index = lines[(current_line_index + 1)..].index do |l|
                               l.start_with?('$')
                             end

                             next_command_input_index = if next_command_input_index.nil?
                                                          lines.length
                                                        else
                                                          next_command_input_index + current_line_index + 1
                                                        end
                             handle_ls_command(lines[(current_line_index + 1)..(next_command_input_index - 1)])

                             next_command_input_index
                           end
    end

    file_system
  end

  private

  attr_reader :lines, :file_system

  def handle_cd_command(directory)
    file_system.change_directory(directory)
  end

  def handle_ls_command(lines_output)
    lines_output.each do |line|
      if line.start_with?('dir')
        file_system.create_directory(line.split(' ').last)
      else
        size, name = line.split(' ')
        file_system.create_file(name, size.to_i)
      end
    end
  end
end
