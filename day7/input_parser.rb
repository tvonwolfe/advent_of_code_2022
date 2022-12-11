class InputParser
  class Command
    def initialize(cmd, *args, output)
      @cmd = cmd
      @args = args
      @output = output
    end

    attr_reader :cmd, :args
  end

  def initialize(*lines); end
end
