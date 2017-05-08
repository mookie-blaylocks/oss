# University of Washington, Programming Languages, Homework 6, hw6runner.rb

# This is the only file you turn in, so do not modify the other files as
# part of your solution.

class MyPiece < Piece
  # The constant All_My_Pieces should be declared here
  All_My_Pieces = [
    [[[0, 0], [1, 0], [0, 1], [1, 1]]],  # square (only needs one)
    rotations([[0, 0], [-1, 0], [1, 0], [0, -1]]), # T
    [[[0, 0], [-1, 0], [1, 0], [2, 0]], # long (only needs two)
     [[0, 0], [0, -1], [0, 1], [0, 2]]],
    rotations([[0, 0], [0, -1], [0, 1], [1, 1]]), # L
    rotations([[0, 0], [0, -1], [0, 1], [-1, 1]]), # inverted L
    rotations([[0, 0], [-1, 0], [0, -1], [1, -1]]), # S
    rotations([[0, 0], [1, 0], [0, -1], [-1, -1]]), # Z
    rotations([[0, 0], [1, 0], [0, -1], [-1, -1], [1, -1]]),
    [[[-2, 0], [-1, 0], [0, 0], [1, 0], [2, 0]],
     [[0, -2], [0, -1], [0, 0], [0, 1], [0, 2]]],
    rotations([[0, 0], [-1, 0], [0, 1]])
  ]
  
  # your enhancements here
  def initialize (point_array, board, piece_size)
    super(point_array, board)
    @len = piece_size
  end
    
  def self.next_piece (board)
    new_piece = All_My_Pieces.sample
    MyPiece.new(new_piece, board, new_piece[0].length)
  end

  def len
    @len
  end
end

class MyBoard < Board
  # your enhancements here
  def initialize (game)
    @grid = Array.new(num_rows) {Array.new(num_columns)}
    @current_block = MyPiece.next_piece(self)
    @score = 0
    @game = game
    @delay = 500
  end

  #move the current block 180 degrees
  def rotate_180
    rotate_clockwise
    rotate_clockwise
  end

  #gets the next piece
  def next_piece
    @current_block = MyPiece.next_piece(self)
    @current_pos = nil
  end

  # gets the information from the current pice about where it is and uses this
  # to store the piece on the board itself. Then calls remove_filled.
  def store_current
    locations = @current_block.current_rotation
    displacement = @current_block.position
    l = @current_block.len - 1
    (0..l).each{|index|;
      current = locations[index];
      @grid[current[1]+displacement[1]][current[0]+displacement[0]] = 
        @current_pos[index]
    }
    remove_filled
    @delay = [@delay - 2, 80].max
  end

end

class MyTetris < Tetris
  # your enhancements here

  #creates a canvas and the board that interacts with it
  def set_board
    @canvas = TetrisCanvas.new
    @board = MyBoard.new(self)
    @canvas.place(@board.block_size * @board.num_rows + 3,
                  @board.block_size * @board.num_columns + 6, 24, 80)
    @board.draw
  end

  def key_bindings
    super
    @root.bind('c', proc {@board.rotate_180})
  end
end


