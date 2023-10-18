# frozen_string_literal: true

class Display
  WIDTH = 40
  HEIGHT = 6

  def initialize
    @pixels = Array.new(WIDTH * HEIGHT, Pixel.new)
  end

  def to_s
    pixels.map(&:to_s).each_slice(WIDTH).to_a.map(&:join).join("\n")
  end

  def inspect
    to_s
  end

  private

  class Pixel
    def initialize(lit: false)
      @lit = lit
    end

    def lit?
      lit
    end

    def lit!
      @lit = true
    end

    def dark?
      !lit?
    end

    def dark!
      @lit = false
    end

    def to_s
      lit? ? '#' : '.'
    end

    private

    attr_reader :lit
  end

  attr_reader :pixels
end
