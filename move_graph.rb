Move = Struct.new(:x, :y, :linked_nodes)

#implements adjacent list
class MoveGraph
  DELTA = [[2,1], [1,2], [-1,2], [-2,1], [-2,-1], [-1,-2], [1,-2], [2,-1]]

  def initialize(coords, max_depth)
    @start = coords
    @max_depth = max_depth
    @array = Array.new(64)
    @node_counter = 1
    generate_moves
  end

  def hash(coord)
    8 * coord[0] + coord[1]
  end

  def generate_moves
    
  end
end
