# frozen_string_literal: true

class Cpu
  class InstructionBase
    class << self
      def num_cycles(num_cycles)
        @num_required_cycles = Integer(num_cycles)
      end

      attr_reader :num_required_cycles
    end

    def initialize(*args)
      @args = args
      @cycles_to_completion = self.class.num_required_cycles
    end

    def done?
      @cycles_to_completion.zero?
    end

    def decrement_counter!
      @cycles_to_completion -= 1
    end

    def perform_op(register)
      raise NotImplementedError
    end

    private

    attr_reader :args
  end

  class NoOpInstruction < InstructionBase
    num_cycles 1

    def perform_op(register)
      register
    end
  end

  class AddInstruction < InstructionBase
    num_cycles 2

    def initialize(*args)
      super(*args)
      @addend = Integer(self.args.first)
    end

    def perform_op(register)
      register + addend
    end

    private

    attr_reader :addend
  end
end
