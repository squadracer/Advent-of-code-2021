module Day15
  def self.parse(input)
    input.split.map { |line| line.chars.map(&:to_i) }
  end

  class Node
    attr_reader :x, :y, :cost, :evaluation

    def initialize(x, y, cost, cavern)
      @x = x
      @y = y
      @cost = cost
      @evaluation = cost + 2 * cavern.size - 2 - x - y
    end

    def childs(cavern)
      neighbours = [[-1, 0], [1, 0], [0, -1], [0, 1]]
      cavern_size = cavern.size
      neighbours.filter_map do |dx, dy|
        current_x = @x + dx
        current_y = @y + dy
        next if current_x.negative? || current_x >= cavern_size || current_y.negative? || current_y >= cavern_size

        current_cost = @cost + cavern[current_y][current_x]
        Day15::Node.new(current_x, current_y, current_cost, cavern)
      end
    end
  end

  def self.solve(cavern)
    queue = [Day15::Node.new(0, 0, 0, cavern)]
    visited = {}
    while queue.any?
      current = queue.shift
      current = queue.shift while visited[[current.x, current.y]]
      visited[[current.x, current.y]] = true
      return current.cost if current.x == cavern.size - 1 && current.y == cavern.size - 1

      addition = current.childs(cavern).reject { |node| visited[[node.x, node.y]] }
      addition.each do |node|
        insert_at = queue.bsearch_index { |queued| queued.evaluation >= node.evaluation }
        if insert_at
          queue.insert(insert_at, node)
        else
          queue << node
        end
      end
    end
  end

  def self.part1(input)
    cavern = parse(input)
    solve(cavern)
  end

  def self.part2(input)
    cavern = parse(input)
    tiles = {}
    tiles[0] = cavern
    (1..8).each do |diff|
      current_tile = cavern.map{_1.map { |v| (v + diff - 1) % 9 + 1 }}
      tiles[diff] = current_tile
    end
    result = []
    [0, 1, 2, 3, 4, 5, 6, 7, 8].each_cons(5) do |tile_line|
      tiles_lines = tile_line.map { |v| tiles[v] }
      cavern.size.times do |l|
        result << tiles_lines.map { |tile| tile[l] }.flatten
      end
    end
    solve(result)
  end
end
