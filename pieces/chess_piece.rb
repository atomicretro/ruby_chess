require 'singleton'

# ChessPiece Master Class
# Also contains NullPiece Class

class ChessPiece
  attr_reader :color, :current_x, :current_y
  attr_accessor :current_pos, :symbol

  def initialize(color, current_pos=nil, symbol_code)
    # symbol_update changes per child ("8"|"E" for knight, etc.)

    # board.new ([pieces] << piece.child.new(color, pos) )
    # type var if it steps, slides, pawn, or null
    update_pos(current_pos)
    @color = color
    @symbol = [(symbol_code).hex].pack("U")
  end

  def move(to_pos)
    valid_move?(to_pos) ? update_and_return_pos(to_pos) : false
  end

  def update_and_return_pos(pos)
    self.update_pos(pos)
    pos
  end

  def update_pos(new_pos)
    @current_pos = new_pos
    @current_x = new_pos[0]
    @current_y = new_pos[1]
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
