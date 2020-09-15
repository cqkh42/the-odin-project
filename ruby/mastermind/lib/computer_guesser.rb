# frozen_string_literal: true

require 'time'
require './guesser'

# For a computer guessing the answers
class ComputerGuesser < Guesser
  def initialize(options)
    super(options, 'Computer')
    @right_answer = pick
    @perms = [*options.permutation(4)]
    @last_guess = nil
  end

  private

  def guess
    sleep(2)
    @last_guess = @perms.pop
    print @last_guess.join(' ')
    puts "\n"
    @last_guess
  end

  def update(right_place, wrong_place)
    @perms = @perms.select { |guess| guess.intersection(@last_guess).length == right_place + wrong_place }
    @perms = @perms.select do |guess|
      (guess.zip(@last_guess).map { |x, y| x == y ? 1 : 0 }).sum == right_place
    end
  end
end
