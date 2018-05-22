require_relative "../pieces/pawn"
require_relative './slidables/slidables_helper'
require_relative './steppables/steppables_helper'

if __FILE__ == $PROGRAM_NAME
  q = Queen.new(:white, [0,4])
  b = Bishop.new(:white, [0,2])
  r = Rook.new(:white, [0,0])
  wpawn1 = Pawn.new(:white, [1,1])
  wpawn2 = Pawn.new(:white, [1,2])
  bpawn1 = Pawn.new(:black, [6,5])
  bpawn2 = Pawn.new(:black, [6,6])

  p "--- queen starting: 0,4"
  q.move([7,4]) # good pos
  p q.current_pos
  q.move([3,3]) # bad pos
  p q.current_pos
  p "--- bishop starting: 0,2"
  b.move([1,3]) # good position
  p b.current_pos
  b.move([0,0]) # bad position
  p b.current_pos
  p "--- rook starting: 0,0"
  r.move([7,0]) # good position
  p r.current_pos
  r.move([3,3]) # bad position
  p r.current_pos
  p "--- wpawn1 starting: 1,1"
  wpawn1.move([2,1]) # good position
  p wpawn1.current_pos
  wpawn1.move([4,1]) # bad position
  p wpawn1.current_pos
  p "--- wpawn2 starting: 1,2"
  wpawn2.move([3,2]) # good position
  p wpawn2.current_pos
  wpawn2.move([3,3]) # bad position
  p wpawn2.current_pos
  p "--- bpawn1 starting: 6,5"
  bpawn1.move([5,5]) # good position
  p bpawn1.current_pos
  bpawn1.move([3,5]) # bad position
  p bpawn1.current_pos
  p "--- bpawn2 starting: 6,6"
  bpawn2.move([4,6]) # good position
  p bpawn2.current_pos
  bpawn2.move([4,7]) # bad position
  p bpawn2.current_pos
end
