require 'byebug'
require 'colorize'

require_relative "../pieces/pawn"
require_relative '../pieces/slidables/slidables_helper'
require_relative '../pieces/steppables/steppables_helper'

class StartPositionError < StandardError
  def initialize(msg="Invalid start position chosen")
    super
  end
end

class EndPositionError < StandardError
  def initialize(msg="Invalid end position chosen")
    super
  end
end

class Board
  BACK_ROW_PIECES = [
    :Rook, :Knight, :Bishop, :King, :Queen, :Bishop, :Knight, :Rook
  ]

  attr_accessor :board

  def initialize
    @board = make_and_fill_board
    @current_player = [:white, :black]
  end

  def [](pos)
    x, y = pos
    board[x][y]
  end

  def []=(pos,piece)
    x, y = pos
    board[x][y] = piece
  end

  def make_and_fill_board
    board_to_return = Array.new(8) { Array.new(8) }

    board_to_return.map.with_index do |row, row_i|
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
  end

  # def each_piece(&prc)
  #
  # end

  def place_piece(row_i, col_i)
    color = (row_i == 0 ? :white : :black)
    current_class = BACK_ROW_PIECES[col_i]
    current_class = Kernel.const_get(current_class)
    # => Converts symbol to class object
    current_class.new(color, [row_i, col_i])
  end

  def place_pawn(row_i, col_i)
    color = (row_i == 1 ? :white : :black)
    Pawn.new(color, [row_i, col_i])
  end

  def move_piece
    begin
      byebug
      start_pos, end_pos = get_moves
      valid_start?(start_pos)
      valid_end?(end_pos)
    rescue StandardError => e
      puts "#{e}: Invalid move, try again."
      retry
    end

  end

  def valid_pos?(pos)
    pos.all? { |val| val.between?(0,7) }
  end

  def in_check?
    their_pawns, their_pieces = [], []
    my_king = get_pieces_for_check(their_pawns, their_pieces)

    their_pawns.each do |pawn|
      return true if pawn.valid_attack?(my_king.current_pos)
    end

    their_pieces.each do |piece|
      return true if piece.valid_move?(my_king.current_pos)
    end

    false
  end

  def get_pieces_for_check(my_color, their_pawns, their_pieces)
    my_king = nil
    my_color, their_color = current_player.first, current_player.last

    board.each do |row|
      row.each do |piece|
        name = piece.class.name
        color = piece.color

        my_king = piece if name == "King" && color == my_color
        their_pawns << piece if name == "Pawn" && color == their_color
        their_pieces << piece if name != "Pawn" && color == their_color
      end
    end

    my_king
  end

  def checkmate?(color)

  end

private
  def get_moves
    result = []
    2.times do |n|
      begin
        puts "Input value \"x,y\": "
        temp_result = gets.chomp.scan(/\d+/).map(&:to_i)
      rescue
        puts "Input is invalid, try again."
        retry
      end

      result << temp_result
    end
    result
  end

  def valid_start?(start_pos)
    pos = self[start_pos]
    if pos.is_a?(ChessPiece) && pos.color == current_player.first
      true
    else
      raise StartPositionError
    end
  end

  def valid_end?(end_pos)
    return true if self[end_pos].is_a?(NullPiece)
    raise EndPositionError
  end
end # class end
