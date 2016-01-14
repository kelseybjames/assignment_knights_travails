require_relative "linked_list.rb"

Move = Struct.new(:x, :y, :linked_nodes)

#implements adjacent list
class MoveGraph
  attr_reader :node_counter
  DELTA = [[2,1], [1,2], [-1,2], [-2,1], [-2,-1], [-1,-2], [1,-2], [2,-1]]

  def initialize(coords, max_depth)
    @start = Move.new(coords[0], coords[1], [])
    @max_depth = max_depth
    @array = Array.new(64)
    @move_history = []
    @node_counter = 1
    generate_moves(@start)
  end

  def hash(coord)
    8 * coord[0] + coord[1]
  end

  def generate_moves(coords)
    DELTA.each do |step|
      new_pos = [coords[0] + step[0], coords[1] + step[1]]
      unless @move_history.include?(new_pos)
        if valid_coord?(new_pos)
          new_move = Move.new(new_pos[0], new_pos[1], [])

          if @array[hash(coords)]
            @array[hash(coords)].add_node(new_move, nil)
          else
            @array[hash(coords)] = LinkedList.new
            @array[hash(coords)].add_node(new_move, nil)
          end

          @move_history << new_pos
          @node_counter += 1
          generate_moves(new_pos)
        end
      end
    end 
  end

  def valid_coord?(new_pos)
    (0..7) === new_pos[0] && (0..7) === new_pos[1]
  end

  def print_graph
    @array.each_with_index do |row, index| 
      puts "Row #{index / 8}, Column #{index % 8}: #{row}" unless row.nil?
    end
  end
end

graph = MoveGraph.new([3,3], 2)
graph.print_graph
puts graph.node_counter