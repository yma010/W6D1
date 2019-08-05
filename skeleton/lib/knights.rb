require_relative "00_tree_node"

class Knight_Pathfinder

    KNIGHTPATHS = [[1, 2], [2, 1], [2, -1], [1, -2], [-1, -2], [-2, -1],[-1, 2], [-2, 1]]

    def initialize(starting_pos)
        @root_node = PolyTreeNode.new(starting_pos)
        @considered_positions = [starting_pos]
        build_move_tree
    end

    def build_move_tree
        seed = [@root_node]
        until seed.empty? 
            leaf = seed.shift  
            new_move_position(leaf.value).each do |branch|
                new_leaf = PolyTreeNode.new(branch)
                leaf.add_child(new_leaf)
                seed << new_leaf
            end
        end
        seed
    end

    def self.valid_moves(pos)
        arr = [] 
        first = pos[0]
        second = pos[1]
        KNIGHTPATHS.each do |moves|
            new_position = [first + moves[0], second + moves[1]]
            arr << new_position if new_position.all?{ |z| 0 <= z && z <= 7 }
        end
        arr
    end

    def new_move_position(pos)
        arr = []

        valid_m = Knight_Pathfinder.valid_moves(pos)
        valid_m.each do |move| 
            if !@considered_positions.include?(move)
                arr << move
                @considered_positions << move
            end
        end
        arr
    end

    def find_path(end_position)
        end_val = @root_node.dfs(end_position)
        trace_path_back(end_val)
    end

    def trace_path_back(end_position)
        empty_arr_path = [end_position.value]
        until end_position.value == @root_node.value
            end_position = end_position.parent
            empty_arr_path << end_position.value
        end
        empty_arr_path.reverse!
    end
end

knights = Knight_Pathfinder.new([0, 0])
p knights.find_path([7, 6]) # => [[0, 0], [1, 2], [2, 4], [3, 6], [5, 5], [7, 6]]
p knights.find_path([6, 2]) # => [[0, 0], [1, 2], [2, 0], [4, 1], [6, 2]]