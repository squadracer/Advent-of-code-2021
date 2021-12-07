module Day02
  def self.parse(input)
    input.split("\n")
  end

  def self.part1(input)
    lines = parse(input)
    x = 0
    y = 0
    lines.each do |line|
      command, value = line.split
      value = value.to_i
      case command
      when 'forward'
        x += value
      when 'up'
        y -= value
      when 'down'
        y += value
      end
    end
    x * y
  end

  def self.part2(input)
    lines = parse(input)
    x = 0
    y = 0
    aim = 0
    lines.each do |line|
      command, value = line.split
      value = value.to_i
      case command
      when 'forward'
        x += value
        y += aim * value
      when 'up'
        aim -= value
      when 'down'
        aim += value
      end
    end
    x * y
  end
end
