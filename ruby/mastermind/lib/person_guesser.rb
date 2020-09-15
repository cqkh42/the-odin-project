# frozen_string_literal: true

require './guesser'

# For a person guessing the answers
class PlayerGuesser < Guesser
  def initialize(options)
    @right_answer = options.sample(4)
    super(options, 'Player')
  end

  alias guess pick
end
