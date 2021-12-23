module Day22
  def self.parse(input)
    steps = []
    input.split("\n").each do |line|
      state, coords = line.split
      state = state == 'on'
      coords = coords.split(',').map { |c| c.split('=').last.split('..').map(&:to_i) }
      steps << [state, coords].flatten(1)
    end
    steps
  end

  def self.intersect(x1,y1, z1, x2, y2, z2)
    !(x1[0] > x2[1] || x1[1] < x2[0] || y1[0] > y2[1] || y1[1] < y2[0] || z1[0] > z2[1] || z1[1] < z2[0])
  end

  def self.intersect_axes(axe, axe2)
    first = []
    last = []
    axe_array = (axe+axe2).sort
    # p "axes array",axe_array
    before = axe_array[0], axe_array[1] - 1
    after = axe_array[2] + 1, axe_array[3]
    inter = [axe_array[1..2]]

    if before[1] >= before[0]
      if before[0] == axe[0]
        first << before
      else
        last << before
      end
    end

    if after[1] >= after[0]
      if after[1] == axe[1]
        first << after
      else
        last << after
      end
    end
    # p ["result", first, inter, last]
    [first, inter, last]
  end

  def self.solve(cuboids)
    processed = []
    cuboids.each do |state, x, y, z|
      next_processed = []
      # p processed.size
      # p [state, x, y, z]

      processed.each do |x1, y1, z1|
        unless intersect(x, y, z, x1, y1, z1)
          next_processed << [x1,y1,z1]
          next
        end
        x_cuboid, x_inter, x_processed = intersect_axes(x, x1)
        y_cuboid, y_inter, y_processed = intersect_axes(y, y1)
        z_cuboid, z_inter, z_processed = intersect_axes(z, z1)
        inter = x_inter.product(y_inter, z_inter)
        pro = (x_processed + x_inter).product(y_processed + y_inter, z_processed + z_inter) - inter
        next_processed += (x_processed + x_inter).product(y_processed + y_inter, z_processed + z_inter) - inter
      end
      next_processed << [x,y,z] if state
      processed = next_processed
      # processed = [[x, y, z]] if processed == [] && state
    end
    processed
  end

  def self.get_volume(cuboid)
    cuboid.map { |a, b| b - a + 1 }.reduce(:*)
  end

  def self.part1(input)
    steps = parse(input)
    steps = steps.filter { |s| intersect(s[1], s[2], s[3], [-50, 50], [-50, 50], [-50, 50]) }
    steps.size
    solve(steps).sum { |cuboid| get_volume(cuboid)}
  end

  def self.part2(input)
    steps = parse(input)
    steps.size
    solve(steps).sum { |cuboid| get_volume(cuboid)}

  end
end
