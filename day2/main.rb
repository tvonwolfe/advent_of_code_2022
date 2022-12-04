# frozen_string_literal: true

require 'byebug'

class RockPaperScissors
  NEEDED_RESULT = {
    'X' => :lose,
    'Y' => :draw,
    'Z' => :win
  }.freeze

  OPPONENT = {
    'A' => :rock,
    'B' => :paper,
    'C' => :scissors
  }.freeze

  WIN_RULES = {
    rock: :scissors,
    paper: :rock,
    scissors: :paper
  }.freeze

  PLAY_POINTS = {
    rock: 1,
    paper: 2,
    scissors: 3
  }.freeze

  def initialize(required_result, opponent_play)
    @opponent = convert_opponent(opponent_play)
    @required_result = NEEDED_RESULT[required_result]
  end

  def result
    score = 0
    play = determine_play
    score += case required_result
             when :win
               6 + PLAY_POINTS[play]
             when :draw
               3 + PLAY_POINTS[play]
             else
               0 + PLAY_POINTS[play]
             end

    score
  end

  private

  def determine_play
    case required_result
    when :win
      WIN_RULES.key(opponent)
    when :draw
      opponent
    else
      WIN_RULES[opponent]
    end
  end

  def convert_opponent(play)
    OPPONENT[play]
  end

  attr_reader :required_result, :opponent
end

games = File.readlines('./input', chomp: true).map do |line|
  opponent, player = line.split(' ')
  RockPaperScissors.new(player, opponent).result
end

puts "#{games.sum}"
