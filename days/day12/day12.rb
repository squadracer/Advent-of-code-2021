module Day12
  def self.parse(input)
    paths = input.split("\n").map { |line| line.split '-' }
    paths += paths.map { |p| p.reverse }
  end

  def self.get_paths(start)
    @network.filter { |n| n.first == start }
  end

  def self.compute_paths(path, start)
    if start == 'end'
      @paths << path
    else
      next_paths = get_paths(start)
      next_paths.each do |s, finish|
        next if finish.downcase == finish && path.include?(finish)

        new_path = path.dup
        new_path << finish
        compute_paths(new_path, finish)
      end
    end
  end

  def self.part1(input)
    @network = parse(input)
    @paths = []
    starts = get_paths('start')
    starts.each do |start, finish|
      path = [start, finish]

      compute_paths(path, finish)
    end
    @paths.uniq.count
  end

  def self.compute_paths_2(path, start)
    if start == 'end'
      @paths << path
    else
      next_paths = get_paths(start)
      next_paths.each do |s, finish|
        next if finish == 'start' || (finish.downcase == finish && path.include?(finish) && (path.filter{ |cave| cave == cave.downcase }.uniq.count { |cave| path.count(cave) > 1 } != 0))

        new_path = path.dup
        new_path << finish
        compute_paths_2(new_path, finish)
      end
    end
  end

  def self.part2(input)
    @network = parse(input)
    @paths = []
    starts = get_paths('start')
    starts.each do |start, finish|
      path = [start, finish]

      compute_paths_2(path, finish)
    end
    @paths.uniq.count
  end
end
