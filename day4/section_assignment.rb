# frozen_string_literal: true

class SectionAssignment
  # @param pair1 [SectionAssignment]
  # @param pair2 [SectionAssignment]
  # @return [Boolean]
  def self.containment?(assignment1, assignment2)
    assignment1.contains?(assignment2) || assignment2.contains?(assignment1)
  end

  def self.overlap?(assignment1, assignment2)
    assignment1.overlaps?(assignment2) || assignment2.overlaps?(assignment1)
  end

  def initialize(start_section, end_section)
    @start_section = start_section
    @end_section = end_section
  end

  def assigned_sections
    @assigned_sections ||= Array(start_section..end_section)
  end

  # @param other_section_assignment [SectionAssignment]
  def contains?(other_section_assignment)
    start_section <= other_section_assignment.start_section &&
      end_section >= other_section_assignment.end_section
  end

  def overlaps?(other_section_assignment)
    assigned_sections.include?(other_section_assignment.start_section) ||
      assigned_sections.include?(other_section_assignment.end_section)
  end

  attr_reader :start_section, :end_section

  private

  attr_reader :assignments
end
