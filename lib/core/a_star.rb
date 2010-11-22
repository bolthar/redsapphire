
module AStar

  class Node

    attr_reader :cell
    
    attr_accessor :estimated_cost

    def initialize(cell)
      @cell = cell
    end

    def parent=(node)
      @parent = node
      @moving_cost = moving_cost
    end

    def moving_cost
      return @parent.moving_cost + 1 if @parent
      return 0
    end

    def total_cost
      return @estimated_cost + @moving_cost
    end

    def ==(other_node)
      return @cell == other_node.cell
    end

    def get_path
      return [@parent.get_path, @cell].flatten if @parent
      return [@cell]
    end

  end
  
  def get_shortest_path(start, target)
    start_node  = Node.new(start)
    target_node = Node.new(target)
    start_node.parent         = nil
    start_node.estimated_cost = estimated_cost(start, target)
    open_list   = [start_node]
    closed_list = []
    counter = 0
    while open_list.any? && !closed_list.include?(target_node) && counter < 29
      counter += 1
      current_square = open_list.sort! { |a, b| a.total_cost <=> b.total_cost }.first
      open_list.delete(current_square)
      closed_list << current_square
      get_neighborhood(current_square.cell).map { |cell| Node.new(cell)}.select do |node|
          (!node.cell.blocked? || node == target_node) && !closed_list.include?(node)
        end.each do |node|
        if !open_list.include?(node)
          node.parent = current_square
          node.estimated_cost = estimated_cost(node.cell, target_node.cell)
          open_list << node
        end        
      end
    end
    target = closed_list.select { |node| node == target_node}.first
    return target.get_path if target
    target = closed_list.min { |a, b| a.estimated_cost <=> b.estimated_cost }
    return target.get_path if target
    return []
  end

  def estimated_cost(source, target)
    return get_line(source, target).length - 1
  end

  def get_neighborhood(cell)
    neighborhood = []
    (cell.x-1..cell.x+1).each do |x|
      (cell.y-1..cell.y+1).each do |y|
        adj_cell = self[x,y]
        neighborhood << adj_cell if adj_cell
      end
    end
    neighborhood.delete(cell)
    return neighborhood
  end

end