require_relative '../chess_piece'
require_relative 'steppable'

class King < ChessPiece
  include Steppable

  def initialize(color, pos)
    symbol_code = "265A"
    super(color, pos, symbol_code)
    # => ChessPiece.new(color, pos, symbol)
  end

end # class end
