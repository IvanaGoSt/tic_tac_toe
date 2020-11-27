class TikTacToe

  attr_reader :x, :y
  attr_accessor :board, :current_player, :possible_moves

  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5 ,9], [3, 5, 7]]

  def initialize
    puts "Let's play..."
    puts "Enter the name of the first player, please."
    @x = Player.new(gets.chomp, "X")
    puts "Enter the name of the second player, please."
    @y = Player.new(gets.chomp, "O")
    @board = (1..9).to_a
    @current_player = x
    @possible_moves = (1..9).to_a
    self.playing
  end

  def board_output
    puts "\n#{board[0]} | #{board[1]} | #{board[2]}\n---------\n#{board[3]} | #{board[4]} | #{board[5]}\n\---------\n#{board[6]} | #{board[7]} | #{board[8]}\n"
    puts
  end

  def change_current_player
    if current_player == x
      self.current_player = y
    else
      self.current_player = x
    end
  end

  def enter_sign
    puts "#{current_player.name}, pick the number for the sign #{current_player.sign}."
    position = gets.chomp.to_i
    while !possible_moves.include?(position)
      puts "Incorrect pick, #{current_player.name}! Try again..."
      position = gets.chomp.to_i
    end
    board[position - 1] = current_player.sign
    current_player.moves << position
    possible_moves.delete(position)
    declare_winner
    change_current_player
  end

  def find_winning_line
    WINNING_LINES.any? { |line| line - current_player.moves == []}
  end

  def declare_winner
    if find_winning_line
      board_output
      puts "Game over! #{current_player.name} won!".upcase
      exit
    end
  end

  def playing
    puts "Playing..."
    board_output

    for i in 1..9
      enter_sign
      board_output
    end

    puts "Game over! It's draw".upcase
  end

end

class Player

  attr_reader :name, :sign
  attr_accessor :moves

  def initialize(name, sign)
    @name = name
    @sign = sign
    @moves = []
  end

end

new_game = TikTacToe.new
