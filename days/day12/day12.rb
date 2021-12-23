module Day12
  def self.parse(input)
    lines = input.split("\n").map { |line| line.split('-') }
    paths = Hash.new([])
    lines.each do |line|
      paths[line.first] += [line.last]
      paths[line.last] += [line.first]
    end
    paths.transform_values { |val| val - ['start'] }
  end

  def self.explore(paths, path)
    return 1 if path.last == 'end'

    paths[path.last].filter { |cave| cave == cave.upcase || !path.include?(cave) }
                    .sum { |cave| explore(paths, path + [cave]) }
  end

  def self.part1(input)
    paths = parse(input)
    explore(paths, ['start'])
  end

  def self.explore2(paths, path)
    return 1 if path.last == 'end'

    paths[path.last].sum do |cave|
      if cave == cave.upcase || !path.include?(cave)
        explore2(paths, path + [cave])
      else
        explore(paths, path + [cave])
      end
    end
  end

  def self.part2(input)
    paths = parse(input)
    explore2(paths, ['start'])
  end
end
