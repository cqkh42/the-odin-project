# frozen_string_literal: true

# makes a lovely game of tic tac toe
class Board
  def initialize
    @board = [*0..8]
  end

  def play
    show
    %i[o x].cycle do |sym|
      move(sym)
      break if winner(sym)
    end
  end

  private

  def show
    r = []
    @board.each_slice(3) { |line| r << line.join('|') }
    puts "\n"
    puts r.join "\n-+-+-\n"
    puts "\n"
  end

  def horizontal_win?(symbol)
    @board.each_slice(3).any? do |row|
      row.all? { |val| val == symbol }
    end
  end

  def vertical_win?(symbol)
    rows = Array(@board.each_slice(3))
    cols = rows[0].zip(rows[1], rows[2])
    cols.any? do |col|
      col.all? { |val| val == symbol }
    end
  end

  def diagonal_win?(symbol)
    diag = @board.each_slice(4).map { |slice| slice[0] }
    diag.all? { |val| val == symbol }
  end

  def draw?
    @board.all? { |item| item.is_a? Symbol }
  end

  def winner(symbol)
    if horizontal_win?(symbol) || vertical_win?(symbol) || diagonal_win?(symbol)
      puts "#{symbol} wins"
      true
    elsif draw?
      puts 'Draw'
      true
    else
      false
    end
  end

  def move(symbol)
    puts "#{symbol} - make a move: "
    choice = gets.chomp.to_i
    if @board[choice].is_a? Numeric
      @board[choice] = symbol
      show
    else
      puts 'That space is taken'
      move(symbol)
    end
  end
end

b = Board.new
b.play
