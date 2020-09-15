# frozen_string_literal: true

require './computer_guesser'
require './person_guesser'

# Everything for a game of mastermind
class Game
  def initialize
    puts 'How many letters do you want to choose from? (4-26)'
    range = gets.chomp.to_i
    @options = [*65...range + 65].map(&:chr)
  end

  def play
    puts 'Do you want to guess or set?'
    case gets.chomp
    when 'guess' then PlayerGuesser.new(@options).play
    when 'set' then ComputerGuesser.new(@options).play
    else
      puts 'Invalid option'
      play
    end
  end
end

Game.new.play
