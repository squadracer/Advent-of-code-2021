module Day11
  def self.parse(input)
    input.split.map { |line| line.chars.map(&:to_i) }
  end

  def self.increase(board, x, y)
    return 0 if x.negative? || y.negative? || x >= board.size || y >= board.size

    neighbours = [[-1, -1], [-1, 0], [-1, 1],
                  [0, -1],           [0, 1],
                  [1, -1], [1, 0], [1, 1]]

    board[y][x] += 1
    board[y][x] == 10 ? 1 + neighbours.sum { |dx, dy| increase(board, x + dx, y + dy) } : 0
  end

  def self.step(board)
    flashes = (0...board.size).sum { |y| (0...board.size).sum { |x| increase(board, x, y) } }
    board.map! { |line| line.map { |cell| cell >= 10 ? 0 : cell } }
    flashes
  end

  def self.part1(input)
    board = parse(input)
    flashes = 0
    100.times do
      flashes += step(board)
    end
    flashes
  end

  def self.part2(input)
    board = parse(input)
    flashes = 0
    i = 0
    while flashes < 100
      flashes = step(board)
      i += 1
    end
    i
  end
end
