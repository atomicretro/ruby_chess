require_relative '../chess_piece'
require_relative 'slidable'

class Bishop < ChessPiece
  include Slidable

  def initialize(color, pos)
    symbol_code = "265D"
    super(color, pos, symbol_code)
    # => ChessPiece.new(color, pos, symbol)
  end

end # class end
