class Game
  attr_accessor :board, :player_1, :player_2
  WIN_COMBINATIONS=[[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

  def initialize(player_1=Players::Human.new("X"),player_2=Players::Human.new("O"),board=Board.new)
    @board=board
    @player_1=player_1
    @player_2=player_2
  end

  def current_player
    board.turn_count.even? ? player_1 : player_2
  end

  def won?
    WIN_COMBINATIONS.detect do |win_combination|
      win_index_1=win_combination[0]
      win_index_2=win_combination[1]
      win_index_3=win_combination[2]
      board.cells[win_index_1]==board.cells[win_index_2]&&board.cells[win_index_3]==board.cells[win_index_2]&&board.cells[win_index_1]!=" "
    end
  end


  def draw?
    board.full?&&!won?
  end

  def over?
    draw?||won?
  end

  def winner
    won? ? board.cells[won?[0]] : nil
  end

  def turn
    current_move=current_player.move(board)
    if !board.valid_move?(current_move)
      turn
    else
      puts "This is turn #{board.turn_count+1}\n"
      board.update(current_move,current_player)
      board.display
      sleep 3
    end
  end

  def play
    while !over?
      puts "Please select a square by entering 1-9, 1 for the top left and 9 for the bottom right:"
      turn
    end
    puts "Congratulations #{winner}!" if won?
    puts "Cat's Game!" if draw?
  end
end
