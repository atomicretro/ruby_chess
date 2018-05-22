require 'byebug'

module Slidable
  QUEENS_OFFSET = [
    -135, 180, 135,
     -90,       90,
     -45,   0,  45
  ]

  BISHOPS_OFFSET = [
    -135,     135,

     -45,      45
  ]

  ROOKS_OFFSET = [
          180,
     -90,      90,
            0
  ]

  def get_attempted_degree(to_pos)
    x1, y1 = @current_pos
    x2, y2 = to_pos

    if x2 - x1 == 0
      if y2 - y1 < 0 # because ruby is weird
        return -90
      elsif y2 - y1 > 0
        return 90
      else
        raise "you broke math"
      end
    end

    x = x2 - x1
    y = y2 - y1
    move_degree = (Math.atan2(y,x) * 180.0) / Math::PI
    move_degree
  end

  def valid_move?(to_pos)
    attempted_degree = get_attempted_degree(to_pos)
    degrees = self.which_slidable
    degrees.any? { |degree| degree == attempted_degree }
  end

  def which_slidable
    if self.is_a?(Queen)
      return QUEENS_OFFSET
    elsif self.is_a?(Bishop)
      return BISHOPS_OFFSET
    elsif self.is_a?(Rook)
      return ROOKS_OFFSET
    else
      raise "Slidable class error"
    end
  end
end
