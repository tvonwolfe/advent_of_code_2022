require_relative 'section_assignment'

lines = File.readlines('input', chomp: true)

assignment_pairs = lines.map do |line|
  line.split(',').map do |assignment_str|
    start_assignment, end_assignment = assignment_str.split('-').map(&:to_i)
    SectionAssignment.new(start_assignment, end_assignment)
  end
end

containments = assignment_pairs
               .select { |pair| SectionAssignment.containment?(pair.first, pair.last) }
               .count

puts containments
