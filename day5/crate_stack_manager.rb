# frozen_string_literal: true

class CrateStackManager
  CrateMovement = Struct.new(:num_crates, :from_stack, :to_stack)

  class MovementError < StandardError; end

  def initialize(*stacks, enable_multi_crate: false)
    # [Hash]
    @stacks = stacks.each_with_object({}).with_index do |(stack, obj), index|
      obj[index + 1] = stack
    end
    @enable_multi_crate = enable_multi_crate
  end

  # crate_movement [CrateMovement] - movement to perform
  def handle_movement(crate_movement)
    from_stack = stacks.fetch(crate_movement.from_stack)
    to_stack = stacks.fetch(crate_movement.to_stack)

    raise MovementError, "stack not found; from: #{from_stack} to: #{to_stack}" if from_stack.nil? || to_stack.nil?

    unless from_stack.count >= crate_movement.num_crates
      raise MovementError,
            "not enough crates in stack #{crate_movement.from_stack}"
    end

    crates = Array(from_stack.pop(crate_movement.num_crates))
    crates.reverse! unless enable_multi_crate
    to_stack.concat(crates)
  end

  def peek
    stacks.each_value.map(&:last)
  end

  attr_reader :stacks, :enable_multi_crate
end
