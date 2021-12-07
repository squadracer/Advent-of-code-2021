module Day01
  def self.parse(input)
    input.split.map(&:to_i)
  end

  def self.solve(depths, window_size)
    depths.each_cons(window_size).count { |depths| depths[-1] > depths[0] }
  end

  def self.part1(input)
    depths = parse(input)
    solve(depths, 2)
  end

  def self.part2(input)
    depths = parse(input)
    solve(depths, 4)
  end
end
