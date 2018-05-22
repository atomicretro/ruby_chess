require 'singleton'

# ChessPiece Master Class
# => Also contains NullPiece Class

class ChessPiece

  attr_reader :color
  attr_accessor :current_pos, :symbol

  def initialize(color, current_pos=nil, symbol_update)
    # symbol_update changes per child ("8"|"E" for knight, etc.)

    # board.new ([pieces] << piece.child.new(color, pos) )
    # type var if it steps, slides, pawn, or null
    @current_pos = current_pos
    @color = color
    # symbol_update should be incoming as a string char
    @symbol = [("265"+symbol_update).hex].pack("U")
    # add defining value in child, then encode
  end

  def move(diff)
    puts "You shouldn't be here!"
  end

  def update_pos(new_pos)
    @current_pos = new_pos
  end

  def display
    # padding space for render
    self.symbol + " "
  end

end

class NullPiece < ChessPiece
  include Singleton

  attr_reader :color, :symbol

  def initialize
    @color = nil
    @symbol = '  '
  end

  def display
    self.symbol
  end
end
