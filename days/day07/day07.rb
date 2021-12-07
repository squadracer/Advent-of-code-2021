module Day07
  def self.parse(input)
    input.split(',').map(&:to_i)
  end

  def self.part1(input)
    crabs = parse(input).sort
    objective = crabs[crabs.size/2]
    crabs.sum{|crab| (crab - objective).abs}
  end

  def self.part2(input)
    crabs = parse(input).sort
    max = crabs.last
    (0..max).map do |objectif|
      crabs.sum{|crab|n = (crab-objectif).abs; (n*n+n)/2}
    end
  end

  def self.part2opti(input)
    crabs = parse(input).sort
    min = 0
    max = crabs.max
    # index = 472
    while min < max
      med = (max+min)/2
      p [min, med, max]
      left = crabs.sum{|crab|n = (crab-med).abs; (n*n+n)/2}
      right = crabs.sum{|crab|n = (crab-med-1).abs; (n*n+n)/2}
      p [left, right]
      if left >= right
        min = med + 1
      else
        max= med
      end
    end
    p [min,max]
    [crabs.sum{|crab|n = (crab-min).abs; (n*n+n)/2}, crabs.sum{|crab|n = (crab-max).abs; (n*n+n)/2}].min
  end
end
