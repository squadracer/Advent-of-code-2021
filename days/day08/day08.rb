module Day08
  def self.parse(input)
    input.split("\n").map { |line| line.split(' | ').map(&:split) }
  end

  def self.part1(input)
    lines = parse(input)
    lines.sum do |l|
      digits = l[1]
      digits.count { |d| [2, 3, 4, 7].include? d.size }
    end
  end

  def self.get_digit_by_count(segments, count)
    segments.filter { |segment| segment.size == count }
  end

  def self.get_digit_by_inclusion(segments, included)
    segments.filter { |segment| (segment & included).sort == included }
  end

  def self.part2(input)
    # 0 ==> (69) contient le 1
    # 1 ==> evident
    # 2 ==> résolu avec le 5
    # 3 ==> (235) contient le 1
    # 4 ==> evident
    # 5 ==> (25) est contenu dans le 9
    # 6 ==> résolu avec le 0
    # 7 ==> evident
    # 8 ==> evident
    # 9 ==> (069) contient le 4
    lines = parse(input)
    lines.sum do |line|
      segments, digits = line
      segments = segments.map(&:chars)
      one = get_digit_by_count(segments, 2)[0].sort
      four = get_digit_by_count(segments, 4)[0].sort
      seven = get_digit_by_count(segments, 3)[0].sort
      eight = get_digit_by_count(segments, 7)[0].sort

      group_of_six = get_digit_by_count(segments, 6)
      nine = get_digit_by_inclusion(group_of_six, four)[0]
      group_of_six.reject! { |segment| segment == nine }
      zero = get_digit_by_inclusion(group_of_six, one)[0]
      group_of_six.reject! { |segment| segment == zero }
      six = group_of_six[0]

      group_of_five = get_digit_by_count(segments, 5)
      three = get_digit_by_inclusion(group_of_five, one)[0]
      group_of_five.reject! { |segment| segment == three }
      five = group_of_five.filter { |segment| (segment & nine).sort == segment.sort }[0]
      group_of_five.reject! { |segment| segment == five }
      two = group_of_five[0]
      decode = [zero, one, two, three, four, five, six, seven, eight, nine].map(&:sort)
      digits.map { |digit| decode.index(digit.chars.sort) }.join.to_i
    end
  end
end
