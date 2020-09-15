# frozen_string_literal: true

require 'yaml'

LIVES = [
  [''],
  ([''] * 4) << '---',
  [' +', ' |', ' |', ' |', '---'],
  [' +---+', ' |', ' |', ' |', '---'],
  [' +---+', ' |   o', ' |', ' |', '---'],
  [' +---+', ' |   o', ' |   |', ' |', '---'],
  [' +---+', ' |   o', ' |  -|', ' |', '---'],
  [' +---+', ' |   o', ' |  -|-', ' |', '---'],
  [' +---+', ' |   o', ' |  -|-', ' |  /', '---'],
  [' +---+', ' |   o', ' |  -|-', ' |  / \ ', '---']
].freeze

# The game hangman
class Hangman
  def initialize
    @word = pick_word
    @guessed = []
    @life = 0
  end

  def play
    until @life == 9 || (@word.split('') - @guessed).empty?
      update_display
      guess = validate_guess
      save if guess == 'save'
      @guessed.append guess
      @life += 1 unless @word.include? guess
    end
    final_score
  end

  def self.load
    YAML.load_file 'saved_game.yml' if File.exist? 'saved_game.yml'
  end

  private

  def final_score
    puts LIVES[@life]
    case @life
    when 9 then puts "You lost. The answer was #{@word}"
    else puts "Well done. You guessed #{@word} in #{@life}" end
  end

  def update_display
    puts LIVES[@life]
    puts uncovered
    puts "guessed: #{@guessed.sort.join ', '}"
  end

  def invalid_guess
    puts 'Invalid guess. Guess again'
    validate_guess
  end

  def validate_guess
    puts 'type save or take a guess: '
    guess = gets.chomp.downcase
    case guess
    when *@guessed then invalid_guess
    when /^([a-z]|save)$/ then guess
    else invalid_guess end
  end

  def pick_word
    words = File.readlines('5desk.txt').map(&:strip).map(&:downcase).uniq
    words.select! { |word| word.length.between?(5, 12) }
    words.sample
  end

  def uncovered
    visible = @word.chars.map { |x| @guessed.include?(x) ? x : '_' }
    visible.join ''
  end

  def save
    puts 'saving game'
    File.write('saved_game.yml', YAML.dump(self))
    exit
  end
end

def load_game
  game = Hangman.load
  game ? game.play : puts('No saved game found')
end

def main
  puts 'Do you want to load the save or play a new game? (load | play)'
  case gets.chomp
  when 'load' then load_game
  when 'play' then Hangman.new.play
  else main end
  puts 'Do you want to play again? (y | n)'
  main if gets.chomp == 'y'
end
main
