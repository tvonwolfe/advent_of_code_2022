# frozen_string_literal: true

require_relative 'instruction'

class Cpu
  attr_reader :register, :cycle_counter

  def self.init(lines)
    instructions = lines.map do |line|
      type, args = line.split(' ')

      case type.to_sym
      when :noop
        NoOpInstruction.new
      when :addx
        AddInstruction.new(*Array(args))
      else
        raise 'unknown instruction type'
      end
    end

    new(instructions: instructions)
  end

  def initialize(instructions: [])
    @instructions = instructions
    @pc = -1

    @cycle_counter = 0
    @register = 1
  end

  def tick
    return next_instruction! if pc.negative?

    if current_instruction.done?
      @register = current_instruction.perform_op(register)
      next_instruction!
    end

    return if complete?

    inc_cycle_counter!
    current_instruction.decrement_counter!
  end

  def complete?
    pc == instructions.count
  end

  private

  def inc_cycle_counter!
    @cycle_counter = cycle_counter + 1
  end

  def next_instruction!
    @pc = pc + 1
  end

  def current_instruction
    instructions[pc]
  end

  attr_reader :instructions, :pc
  attr_writer :cycle_counter, :register
end
