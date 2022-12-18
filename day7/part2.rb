require_relative 'file_system'
require_relative 'input_parser'

REQUIRED_SPACE = 30_000_000
TOTAL_DISK_SPACE = 70_000_000

file_tree = File.open('input') do |file|
  InputParser.build_file_tree(file)
end

used_space = FileSystem::Node.calculated_size(file_tree.root)

free_space = TOTAL_DISK_SPACE - used_space

need_to_free = REQUIRED_SPACE - free_space

puts "used space:   #{used_space}"
puts "free space:   #{free_space}"
puts "need to free:  #{need_to_free}"

node_to_delete = file_tree
                 .directories
                 .select { |dir| FileSystem::Node.calculated_size(dir) >= need_to_free }
                 .min_by { |dir| FileSystem::Node.calculated_size(dir) }

to_free = FileSystem::Node.calculated_size(node_to_delete)

puts "will free:    #{to_free}"
puts "new total:    #{free_space + to_free}"
