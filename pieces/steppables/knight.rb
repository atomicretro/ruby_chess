require_relative '../chess_piece'
require_relative 'steppable' # file_name


class Knight < ChessPiece # brain slug symbol (BSS)
  include Steppable # ModuleName

  def initialize(color, pos)
    symbol_update = (color == :white ?  "8" : "E")
    super(color, pos, symbol_update)
    # => ChessPiece.new(color, pos, symbol)
  end

end # class end
