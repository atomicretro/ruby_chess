require_relative '../chess_piece'
require_relative 'slidable'

class Queen < ChessPiece
  include Slidable

  def initialize(color, pos)
    symbol_code = "265B"
    super(color, pos, symbol_code)
    # => ChessPiece.new(color, pos, symbol)
  end

end # class end
