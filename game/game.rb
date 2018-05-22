require 'byebug'
require 'colorize'
# require_relative '../pieces/chess_piece'
require_relative '../pieces/steppables/steppables_helper'
require_relative '../pieces/slidables/slidables_helper'
require_relative "../pieces/pawn"

class Game
  PIECES_POS = [
    :Rook, :Knight, :Bishop, :King, :Queen, :Bishop, :Knight, :Rook
  ]

  attr_accessor :board

  def initialize
    @board = make_and_fill_board
  end

  def [](pos)
    x, y = pos
    board[x][y]
  end

  def []=(pos,piece)
    x,y = pos
    board[x][y] = piece
  end

  def make_and_fill_board
    temp_board = Array.new(8) { Array.new(8) }

    temp_board.map.with_index do |row, row_i|
      row.map.with_index do |col, col_i|
        case row_i
          when 0, 7
            col = place_piece(row_i, col_i)
          when 1, 6
            col = place_pawn(row_i, col_i)
          else
            col = NullPiece.instance
        end
      end
    end
  end # make and fill board END

  def place_piece(row_i, col_i)
    # Knight.new(:white, [0,0])
    # a;lksda;ls(color, [row_i, col_i])
    color = (row_i == 0 ? :white : :black)

    # PIECES == :Rook, etc.
    cur_class = PIECES_POS[col_i]
    # Converts to class_name_object_thing
    cur_class = Kernel.const_get(cur_class)
    # Makes a new piece of class, color, indexes
    new_piece = cur_class.new(color, [row_i, col_i])
    return new_piece
  end

  def place_pawn(row_i, col_i)
    color = (row_i == 1 ? :white : :black)
    # Makes a new piece of class, color, indexes
    new_piece = Pawn.new(color, [row_i, col_i])
    return new_piece
  end



  def move_piece
    begin
      start_pos, end_pos = get_moves
      check_start_pos(start_pos)
      check_end_pos(end_pos)
    rescue StandardError => e
      puts "#{e}: Invalid move, try again."
      retry
    end
    #

    # flip pieces ## @set = draw
    self[end_pos], self[start_pos] = self[start_pos], self[end_pos]

  end

  def valid_pos?(pos)
    pos.all? { |val| val.between?(0,7) }
  end

  # # make a copy in board for collision
  #  def find_vector(end_pos)
  #    #finds directions from start_pos to end_pos
  #    #returns vector if possible else returns false
  #    #vector of self.current_pos and end_pos
  #
  #    # TDA: board => you can move through this space
  #      # => piece: cool, thanks. I'm moving now.
  #
  #    moving_pos = [] #calculate moving_pos
  #    offsets = which_slider
  #    vector == offsets.any?
  #    until moving_pos == end_pos
  #
  #    end
  #  end

private
  def get_moves
    result = []
    2.times do |n|
      begin
        puts "Input value \"x,y\": "
        temp_result = gets.chomp.scan(/\d+/).map(&:to_i)
        valid!(temp_result) # tests temp result
      rescue
        puts "Input is invalid, try again."
        retry
      end

      result << temp_result
    end
    result
  end

  def valid!(temp_result)
    raise StandardError if valid?(temp_result)
  end

  def valid?(temp_result)
    temp_result.length == 2 || temp_result.any? { |val| val < 0 || val > 7 }
  end

  def check_start_pos(start_pos) #make error more detailed
    #returns true if end_pos is ChessPiece
    return true if self[start_pos].is_a?(ChessPiece)
    raise StandardError.new("Start_pos Error")
  end

  def check_end_pos(end_pos)
    #returns true if end_pos is NullPiece
    return true if self[end_pos].is_a?(NullPiece)
    raise StandardError.new("End_pos Error")
  end

end # class end


if __FILE__ == $PROGRAM_NAME
  b = Board.new
  b.move_piece
  b.display
end
