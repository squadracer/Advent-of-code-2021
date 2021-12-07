module Day05
  def self.parse(input)
    input.split("\n").map { |line| line.split(' -> ').map { |point| point.split(',').map(&:to_i) } }
  end

  def self.init_board(vents)
    maxx = 0
    maxy = 0
    vents.each do |v|
      v.each do |p|
        maxx = [maxx, p.first].max
        maxy = [maxy, p.last].max
      end
    end
    Array.new(maxy + 1) { Array.new(maxx + 1) { 0 } }
  end

  def self.solve(vents, part)
    board = init_board(vents)
    vents.each do |v|
      next if part == 1 && v.first.first != v.last.first && v.first.last != v.last.last

      dx = v.last.first - v.first.first
      dy = v.last.last - v.first.last
      dx = dx <=> 0
      dy = dy <=> 0
      x = v.first.first
      y = v.first.last
      while x != v.last.first || y != v.last.last
        board[y][x] += 1
        x += dx
        y += dy
      end
      board[y][x] += 1
    end
    board.flatten.count { |value| value >= 2 }
  end

  def self.part1(input)
    vents = parse(input)
    solve(vents, 1)
  end

  def self.part2(input)
    vents = parse(input)
    solve(vents, 2)
  end
end
