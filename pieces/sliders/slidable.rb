require 'byebug'

module Slidable
  QUEENS_OFF = [
    -135, 180, 135,
    -90,       90,
    -45,   0,  45
  ]

  BISHOPS_OFF = [
    -135,     135,

    -45,       45
  ]

  ROOKS_OFF = [
          180,
    -90,       90,
           0
  ]

def get_degree(to_pos)
  x1,y1 = @current_pos
  x2,y2 = to_pos

  if x2 - x1 == 0
    if y2 - y1 < 0 # because ruby is weird
      return -90
    elsif y2 - y1 > 0
      return 90
    else
      raise "what the fuck?"
    end
  end

  x = x2 - x1
  y = y2 - y1
  move_degree = (Math.atan2(y,x) * 180.0) / Math::PI
  return move_degree
end

  def move(to_pos)
    if valid_move?(to_pos)
      self.update_pos(to_pos)  # update self to new_pos
      return to_pos             # return to board
    else
      return false
    end
  end

  def valid_move?(to_pos)
    check_degree = get_degree(to_pos)
    degrees = self.which_slider
    degrees.any? { |degree| degree == check_degree }
  end

  def which_slider
    if self.is_a?(Queen)
      return QUEENS_OFF
    elsif self.is_a?(Bishop)
      return BISHOPS_OFF
    elsif self.is_a?(Rook)
      return ROOKS_OFF
    else
      raise "Slidable class error."
    end
  end
end
