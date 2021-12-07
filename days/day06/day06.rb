module Day06
  def self.parse(input)
    input = input.split(',').map(&:to_i)
    fishes = Array.new(9) { 0 }
    input.each { |fish| fishes[fish] += 1 }
    fishes
  end

  def self.solve(fishes, days)
    days.times do
      fishes[7] += fishes[0]
      fishes.rotate!(1)
    end
    fishes.sum
  end

  def self.part1(input)
    fishes = parse(input)
    solve(fishes, 80)
  end

  def self.part2(input)
    fishes = parse(input)
    solve(fishes, 256)
  end
end
