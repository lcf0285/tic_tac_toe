require_relative './player'
require_relative './board'

class Game
  attr_reader :board

  def initialize(board = Board.new)
		@board = board
	end

  def instructions
    puts "\n\nINSTRUCTIONS"
    puts "Use the 1-9 keys to make your turn.\n\n"
    puts "        1|2|3"
    puts "        4|5|6"
    puts "        7|8|9"
  end

  def create_players
    puts "\n\nPlease enter the name of player 1:"
    name1 = gets.chomp
    puts "\n\nPlease enter the name of player 2:"
    name2 = gets.chomp
    @players = [Player.new(name1), Player.new(name2)]
  end

  def assign_players
    x_or_o = ["X","O"].shuffle
    @players[0].preference = x_or_o[0]
    @players[1].preference = x_or_o[1]
    puts "\n\n#{@players[0].name} has been randomly assigned to #{@players[0].preference}."
    puts "Therefore, #{@players[1].name} has been assigned to #{@players[1].preference}."
  end

  def who_goes_first
    @players.shuffle!
    puts "\nThe computer has randomly decided that #{@players[1].name} will go first.\n\n"
  end

	def turn
		puts "\n#{@players[0].name}, please take your turn:"
		turn = gets.chomp
		until input_valid?(turn) && board.move_valid?(turn.to_i)
			puts "Invalid input.  Please use keys 1-9 to choose an empty position.\n\n"
			turn = gets.chomp
		end
		board.take_turn(turn.to_i, @players[0].preference)
	end
	
	def input_valid?(turn)
		("1".."9").to_a.include?(turn)
	end

  def intro
    instructions
    create_players
    assign_players
    who_goes_first
  end

	def play
    intro
		until board.game_over?(@players[0].preference)
			@players.reverse!
			turn
      board.display_game
		end
    closing
  end

  def closing
		puts "\nGame over!"
		board.win?(@players[0].preference) ? (puts "\nCongrats, #{@players[0].name}!!") : (puts "\nTie!")
	end
end

game = Game.new
game.play