
class TTTBoard
  attr_reader :spaces

  @@winning = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [6, 4, 2]]

  def initialize
    @spaces = Array.new(9, " ")
  end

  def mark (space, value)
    @spaces[space] = value.upcase if value.upcase == 'X' || value.upcase == 'O'
  end

  def winner
    retVal = nil

    ['X', 'O'].each do |val|
      @@winning.each do |space|
        if val == spaces[space[0]] && val == spaces[space[1]] && val == spaces[space[2]]
          retVal = val
        end
      end
    end

    return retVal
  end

  def to_s
    retVal = "   |   |   \n"
    retVal << "   |   |   \n"
    retVal << "   |   |   \n"
    retVal << "---+---+---\n"
    retVal << "   |   |   \n"
    retVal << "   |   |   \n"
    retVal << "   |   |   \n"
    retVal << "---+---+---\n"
    retVal << "   |   |   \n"
    retVal << "   |   |   \n"
    retVal << "   |   |   "

    retVal[13] = spaces[0]
    retVal[17] = spaces[1]
    retVal[21] = spaces[2]
    retVal[61] = spaces[3]
    retVal[65] = spaces[4]
    retVal[69] = spaces[5]
    retVal[109] = spaces[6]
    retVal[113] = spaces[7]
    retVal[117] = spaces[8]

    return retVal
  end

  def empty_spaces
    retVal = []
    @spaces.each_index {|index| retVal << index if @spaces[index] == " "}
    return retVal
  end

end

play_again = true

puts "Welcome to Tic-Tac-Toe"

while play_again
  board = TTTBoard.new
  winner = nil
  turn = 1

  puts board.to_s

  until turn > 9

    #prompt user for play
    print "Choose a position (from 1 to 9) to place a piece: "
    player_input = gets.chomp.to_i
    until board.empty_spaces.include?(player_input - 1)
      puts "Invalid input."
      print "Choose a position (from 1 to 9) to place a piece: "
      player_input = gets.chomp.to_i
    end

    # make player's move
    board.mark(player_input - 1, 'X')
    puts "Your move:"
    puts board.to_s
    break if (winner = board.winner) == 'X'

    # make computer's move
    board.mark(board.empty_spaces.sample, 'O')
    puts "computer plays:"
    puts board.to_s
    break if (winner = board.winner) == 'O'

    turn = turn + 1
  end

  puts board.to_s

  if winner == 'X'
    puts "You win!"
  elsif winner == 'O'
    puts "Computer wins!"
  else
    puts "Cat's game!"
  end

  # prompt for replay
  puts "Play again? (Y/N)"
  play_again_input = gets.chomp
  play_again = false unless play_again_input.upcase == "Y"
end
