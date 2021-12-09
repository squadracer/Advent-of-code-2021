module Day09
  def self.parse(input)
    input.split("\n").map do |line|
      line.chars.map(&:to_i)
    end
  end

  def self.cell(board, x, y)
    return nil if x < 0 || y < 0 || x >= board[0].size || y >= board.size

    board[y][x]
  end
  
  VECTORS = [[1, 0],[-1, 0],[0, 1],[0, -1]]

  def self.neighbours(board, x, y)

    VECTORS.filter_map{ |dx, dy| cell(board, x + dx, y + dy)}
  end

  def self.part1(input)
    board = parse(input)
    sum = 0
    local_mins(board) do |x, y|
      sum += 1 + cell(board, x, y)
    end
    sum
  end

  def self.local_mins(board)
    (0...board.size).each do |y|
      (0...board[0].size).each do |x|
        yield [x, y] if cell(board, x, y) < neighbours(board, x, y).min
      end
    end
  end

  def self.floodfill(board, x,y)
    return 0 if cell(board, x, y).nil? || cell(board, x, y) > 8

    board[y][x] = 9
    1 + VECTORS.sum { |dx, dy| floodfill(board, x + dx, y + dy) }
  end

  def self.part2(input)
    board = parse(input)
    basin = []
    local_mins(board) do |x, y|
      basin << floodfill(board, x, y)
    end
    basin.max(3).reduce(:*)
  end
end
