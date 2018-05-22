require_relative 'queen'
require_relative 'bishop'
require_relative 'rook'

if __FILE__ == $PROGRAM_NAME
  q = Queen.new(:black, [0,4])
  b = Bishop.new(:black, [0,2])
  r = Rook.new(:black, [0,0])

  p q

  q.move([7,4]) # good pos
  p q.current_pos
  q.move([3,3]) # bad pos
  p q.current_pos
  p "---"
  b.move([1,3]) # good position
  p b.current_pos
  b.move([0,0]) # bad position
  p b.current_pos
  p "---"
  r.move([7,0]) # good position
  p r.current_pos
  r.move([3,3]) # bad position
  p r.current_pos
end
