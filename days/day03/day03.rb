module Day03
  def self.parse(input)
    input.split("\n")
  end

  def self.part1(input)
    input = parse(input).map(&:chars).transpose
    gamma = ''
    input.each do |column|
      gamma += column.count('1') * 2 > column.size ? '1' : '0'
    end
    gamma.to_i(2) * gamma.tr('10', '01').to_i(2)
  end

  def self.get_rate(report, max)
    index = 0
    while report.size > 1
      column = report.map { |line| line[index] }
      filter = (column.count('1') * 2 >= column.size) ^ max ? '1' : '0'
      report.filter! { |line| line[index] == filter }
      index += 1
    end
    report[0].join.to_i(2)
  end

  def self.part2(input)
    report = parse(input).map(&:chars)
    oxygen = get_rate(report.dup, true)
    co2 = get_rate(report.dup, false)
    oxygen * co2
  end
end
