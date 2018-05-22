require 'byebug'

module Steppable
  KNIGHTS_OFFSET = [
    [-1, -2], [1, -2],
    [-2, -1], [2, -1],
    [-2, -1], [2,  1],
    [-1,  2], [1,  2]
  ]

  KINGS_OFFSET = [
    [-1, -1], [-1, 0], [-1, 1],
    [ 0, -1],          [ 0, 1],
    [ 1, -1], [1,  0], [ 1, 1]
  ]

  def valid_move?(to_pos)
    attempted_offset = get_attempted_offset(to_pos)
    offsets = self.which_steppable
    offsets.any? { |offset| offset == attempted_offset }
  end

  def get_attempted_offset(to_pos)
    to_x, to_y = to_pos
    [to_x - current_pos[0], to_y - current_pos[1]]
  end

  def which_steppable
    if self.is_a?(King)
      KINGS_OFFSET
    elsif self.is_a?(Knight)
      KNIGHTS_OFFSET
    else
      raise "Steppable class error"
    end
  end
end
