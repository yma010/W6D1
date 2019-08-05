class PolyTreeNode
    attr_reader :parent, :children, :value
    def initialize(value)
        @parent = nil 
        @children = Array.new 
        @value = value
    end

    def inspect 
        self.value
    end

    def parent=(parent)
        return self if self.parent == parent 
        
        if self.parent
            self.parent.children.delete(self)
        end

        @parent = parent
        
        if !self.parent.nil?
            self.parent.children << self
        end
        self
    end

    def add_child(child)
        child.parent = self
    end

    def remove_child(child)
        if !self.children.include?(child)
            raise "Not your child"
        end
        child.parent = nil
    end

    def dfs(target, &prc)
        prc ||= Proc.new{ |node| node.value == target }
        return self if prc.call(self)
        children.each do |child|
            val = child.dfs(target, &prc)
            unless val == nil 
                return val  
            end
        end
        nil 
    end

    def bfs(target, &block)
        block ||= Proc.new{ |node| node.value == target }
        return self if self.value == target
        
        queue = []

        children.each { |child| queue << child}
    
        until queue.empty?
            first = queue.shift
            return first if block.call(first)
            queue += first.children
        end

        nil
    end
end

