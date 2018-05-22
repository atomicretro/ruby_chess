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
    # current_pos +- 1 y
    x, y = to_pos
    if valid_move?(x, y)
      self.update_pos(to_pos)
      return to_pos
    else
      false
    end
  end

  def valid_move?(to_x, to_y)
    # valid move must be in same column
    to_y == current_y ? (current_x - to_x).abs <= max_move : false
  end

  def max_move
    row = current_pos[0]
    row == 1 || row == 6 ? 2 : 1
  end

  def attack_move(attack_pos)
    if valid_attack?(attack_pos)
      self.update_pos(attack_pos)
      attack_pos
    else
      false
    end
  end

  def valid_attack?(attack_pos)
    ATTACKS_OFFSET.any? { |move| move == attack_pos }
  end
end
