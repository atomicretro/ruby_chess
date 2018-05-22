require 'byebug'
require_relative 'chess_piece'

class Pawn < ChessPiece
  ATTACKS_OFFSET = [
    [-1,-1], [-1, 1],
    [ 1,-1], [ 1, 1]
  ]

  def initialize(color, pos)
    symbol_code = "265F"
    super(color, pos, symbol_code)
    # => ChessPiece.new(color, pos, symbol)
  end

  def move(to_pos)
    valid_move?(to_pos) ? update_and_return_pos(to_pos) : false
  end

  def update_and_return_pos(pos)
    self.update_pos(pos)
    pos
  end

  def valid_move?(to_pos)
    # valid move must be in same column
    to_x, to_y = to_pos
    to_y == current_y ? (current_x - to_x).abs <= max_move : false
  end

  def max_move
    row = current_pos[0]
    row == 1 || row == 6 ? 2 : 1
  end

  def attack(pos)
    valid_attack?(pos) ? update_and_return_pos(pos) : false
  end

  def valid_attack?(pos)
    ATTACKS_OFFSET.any? { |move| move == pos }
  end
end
