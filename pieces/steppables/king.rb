require_relative '../chess_piece'
require_relative 'steppable'

class King < ChessPiece
  include Steppable

  def initialize(color, pos)
    symbol_update = (color == :white ?  "4" : "A")
    super(color, pos, symbol_update)
    # => ChessPiece.new(color, pos, symbol)
  end

end # class end
