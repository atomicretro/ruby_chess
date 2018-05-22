require 'byebug'

module Steppable
  KNIGHTS_OFF = [
    [-1,-2], [1,-2],
    [-2,-1], [2,-1],
    [-2,-1], [2,1],
    [-1, 2], [1,2]
  ]

  KINGS_OFF = [
    # moves from center, [+0-,+0-] in all directions
    [-1,-1], [-1,0], [-1, 1],
    [0, -1],         [0, 1],
    [1, -1], [1, 0], [1, 1],
  ]

  def move(to_pos)
    x,y = to_pos
    # relative to move_module
    if valid_move?(x, y)
      self.update_pos(to_pos)  # update self to new_pos
      return to_pos             # return to board
    else
      return false
    end
  end

  def find_attempted_move(x, y)
    [x - current_pos[0], y - current_pos[1]]
  end

  def valid_move?(x, y)
    check_pos = find_attempted_move(x, y)
    offsets = self.king_or_knave
    offsets.any? { |move| move == check_pos }
  end

  def king_or_knave
    if self.is_a?(King)
      return KINGS_OFF
    elsif self.is_a?(Knight)
      return KNIGHTS_OFF
    else
      raise "Steppable class error."
    end
  end
end
