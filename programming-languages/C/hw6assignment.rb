# University of Washington, Programming Languages, Homework 6, hw6runner.rb

# This is the only file you turn in, so do not modify the other files as
# part of your solution.

class MyPiece < Piece
  # The constant All_My_Pieces should be declared here
  # your enhancements here
  # class array holding all the pieces and their rotations
  def self.next_piece (board)
    MyPiece.new(All_Pieces.sample, board)
  end
  
  All_Pieces = [
#    [[[0, 0], [1, 0], [0, 1], [1, 1]]],  # square (only needs one)
#    rotations([[0, 0], [-1, 0], [1, 0], [0, -1]]), # T
#    [[[0, 0], [-1, 0], [1, 0], [2, 0]], # long (only needs two)
#     [[0, 0], [0, -1], [0, 1], [0, 2]]],
    [[[0, 0], [-1, 0], [1, 0], [-2, 0], [2, 0]], # x-long alt-shape 2
     [[0, 0], [0, -1], [0, 1], [0, -2], [0, 2]]],
#    rotations([[0, 0], [0, -1], [0, 1], [1, 1]]), # L
    rotations([[0, 0], [0, -1], [0, 1], [1, 1], [1,0]]), # first alt-shape
#    rotations([[0, 0], [0, -1], [0, 1], [-1, 1]]), # inverted L
    rotations([[0, 0], [0, 1], [1, 0]]), # alt-shape 3
#    rotations([[0, 0], [-1, 0], [0, -1], [1, -1]]), # S
#    rotations([[0, 0], [1, 0], [0, -1], [-1, -1]]) # Z
  ]

end


class MyBoard < Board
  # your enhancements here
  def rotate_flip
    if !game_over? and @game.is_running?
      @current_block.move(0, 0, 2)
    end
    draw
  end

  def store_current
    locations = @current_block.current_rotation
    displacement = @current_block.position
    (0..3).each{|index|
      current = locations[index];
      @grid[current[1]+displacement[1]][current[0]+displacement[0]] =
        @current_pos[index]
    }
    remove_filled
    @delay = [@delay - 2, 80].max
  end
  
  def next_piece
    @current_block = MyPiece.next_piece(self)
    @current_pos = nil
  end
end


class MyTetris < Tetris
  # your enhancements here

  def set_board
    @canvas = TetrisCanvas.new
    @board = MyBoard.new(self)
    @canvas.place(@board.block_size * @board.num_rows + 3,
                  @board.block_size * @board.num_columns + 6, 24, 80)
    @board.draw
  end
  
  def key_bindings
    @root.bind('n', proc {self.new_game}) 

    @root.bind('p', proc {self.pause}) 
    
    @root.bind('q', proc {exitProgram})
    
    @root.bind('a', proc {@board.move_left})
    @root.bind('Left', proc {@board.move_left}) 
    
    @root.bind('d', proc {@board.move_right})
    @root.bind('Right', proc {@board.move_right}) 
    
    @root.bind('s', proc {@board.rotate_clockwise})
    @root.bind('Down', proc {@board.rotate_clockwise})
    @root.bind('c', proc {@board.rotate_flip})
    
    @root.bind('w', proc {@board.rotate_counter_clockwise})
    @root.bind('Up', proc {@board.rotate_counter_clockwise}) 
    
    @root.bind('space' , proc {@board.drop_all_the_way}) 
  end

end


