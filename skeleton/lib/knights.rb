require "00_tree_node.rb"

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
            leaf = seed.shift.value  
            new_move_position(leaf).each do |branch|
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

        valid_m = self.valid_moves(pos)
        valid_m.each do |move| 
            if !considered_positions.include?(move)
                arr << move
                considered_positions << move
            end
        end
        arr
    end
end