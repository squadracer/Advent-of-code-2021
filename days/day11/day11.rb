module Day11
  def self.parse(input)
    input.split("\n").map { |line| line.chars.map(&:to_i) }
  end

  def self.part1(input)
    @array = parse(input)
    flashing_count = 0
    100.times do
      flashing_octopuses = []

      @array.map do |line|
        line.map! { |octopus| octopus + 1 if octopus }
      end

      @array.each_with_index do |line, y|
        line.each_with_index do |octopus, x|
          flashing_octopuses << [x, y] if octopus > 9
        end
      end

      flashing_octopuses.each do |flashing_octopus|
        enligth_octopus(flashing_octopus)
      end

      @array.each_with_index do |line, y|
        line.each_with_index do |octopus, x|
          if octopus > 9
            @array[y][x] = 0
            flashing_count += 1
          end
        end
      end
    end

    flashing_count
  end

  def self.enligth_octopus(octopus)
    octopus_neighbors = get_neighbors(octopus) 
    octopus_neighbors.each do |current_octopus|
      octopus_x, octopus_y = current_octopus
      next if octopus[0] == octopus_x && octopus[1] == octopus_y

      @array[octopus_y][octopus_x] += 1
      enligth_octopus(current_octopus) if @array[octopus_y][octopus_x] == 10
    end
  end


  def self.get_neighbors(octopus)
    x, y = octopus
    [
      [[x - 1, 0].max, [y - 1, 0].max],
      [[x, 0].max, [y - 1, 0].max],
      [[x + 1, 9].min, [y - 1, 0].max],
      [[x - 1, 0].max, y],
      [[x + 1, 9].min, y],
      [[x - 1, 0].max, [y + 1, 9].min],
      [[x, 0].max, [y + 1, 9].min],
      [[x + 1, 9].min, [y + 1, 9].min]
    ].uniq
  end

  def self.part2(input)
    @array = parse(input)
    flashing_count = 0
    steps = 0
    while flashing_count != 100 do
      steps += 1
      flashing_count = 0
      flashing_octopuses = []

      @array.map do |line|
        line.map! { |octopus| octopus + 1 if octopus }
      end

      @array.each_with_index do |line, y|
        line.each_with_index do |octopus, x|
          flashing_octopuses << [x, y] if octopus > 9
        end
      end

      flashing_octopuses.each do |flashing_octopus|
        enligth_octopus(flashing_octopus)
      end

      @array.each_with_index do |line, y|
        line.each_with_index do |octopus, x|
          if octopus > 9
            @array[y][x] = 0
            flashing_count += 1
          end
        end
      end
    end
    steps
  end
end
