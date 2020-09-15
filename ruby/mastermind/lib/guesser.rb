# frozen_string_literal: true

# Base class for guessing the answers
class Guesser
  def initialize(options, name)
    @options = options
    @name = name
    @guesses = 12
  end

  def play
    guess = nil
    puts "\n"
    until @guesses.zero? || guess == @right_answer
      guess = self.guess
      @guesses -= 1
      update(*report(guess))
    end
    final_string
  end

  private

  def report(guess)
    right_place = (@right_answer.zip(guess).select { |c, g| c == g }).length
    all_place = (guess.select { |g| @right_answer.include? g }).length

    puts "#{right_place} right letter, right slot."
    puts "#{all_place - right_place} right letter, wrong slot."
    puts "#{@guesses} guesses remaining"
    puts "\n"
    [right_place, all_place - right_place]
  end

  def final_string
    if @guesses.zero?
      puts "#{@name} loses. Couldn't guess #{@right_answer.join(' ')}"
    else
      puts "#{@name} wins. Guessed in #{12 - @guesses}"
    end
  end

  def pick
    puts "Pick Your Options: #{@options.join ' '}. e.g. 'A B C D'"
    arr = gets.chomp.split(' ')
    return arr unless arr.uniq.intersection(@options).length < 4

    puts 'Should be 4 unique letters. Pick again.'
    guess
  end


  def update(*_); end
end
