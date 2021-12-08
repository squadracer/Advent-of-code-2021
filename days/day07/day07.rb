module Day07
  def self.parse(input)
    input.split(',').map(&:to_i)
  end

  def self.part1(input)
    crabs = parse(input).sort
    target = crabs[crabs.size / 2]
    crabs.sum { |crab| (crab - target).abs }
  end

  def self.fuel_consumed(crabs, target)
    crabs.sum do |crab|
      n = (crab - target).abs
      (n * n + n) / 2
    end
  end

  def self.part2(input)
    crabs = parse(input).sort
    max = crabs.last
    (0..max).map do |target|
      fuel_consumed(crabs, target)
    end
  end

  def self.part2opti(input)
    crabs = parse(input).sort
    min = 0
    max = crabs.max
    while min < max
      med = (max + min) / 2
      left = fuel_consumed(crabs, med)
      right = fuel_consumed(crabs, med + 1)
      if left >= right
        min = med + 1
      else
        max = med
      end
    end
    fuel_consumed(crabs, max)
  end
end
