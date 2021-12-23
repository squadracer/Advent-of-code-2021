module Day18
  def self.parse(input)
    numbers = input.split("\n").map { |line| eval(line).to_s}
  end

  def self.compute_magnitude(input)
    if input.first.is_a?(Array)
      input[0] = compute_magnitude(input.first)
    end
    if input.last.is_a?(Array)
      input[-1] = compute_magnitude(input.last)
    end
    3 * input.first + 2 * input.last
  end

  def self.reduce_number(number)
    while true
      explode_indexes = []
      number.gsub(/\[\d+, \d+\]/) { explode_indexes << $~.offset(0) }
      explode = explode_indexes.find do |index|
        substr = number[0...index[0]]
        substr.count('[') - substr.count(']') >= 4
      end
      split_index = nil
      number.sub(/\d\d+/) { split_index = $~.offset(0) }
      break if explode.nil? && split_index.nil?
      if explode.nil? # split
        a = number[split_index[0]...split_index[1]].to_f / 2.0
        number[split_index[0]...split_index[1]] = [a.floor, a.ceil].to_s
      else # explode
        substr = number[explode[0]..explode[1]]
        a, b = substr.scan(/\d+/).map(&:to_i)
        left = number.rindex(/[^0123456789]\d/, explode[0]-1)
        right = number.index(/\d+/, explode[1]+1)
        right_length = number[right..].to_i.to_s.size
        left +=1 if left
        left_length = number[left..].to_i.to_s.size
        number[right...(right + right_length)] = (number[right..].to_i + b).to_s if right
        number[explode[0]...explode[1]] = '0'
        number[left...(left + left_length)] = (number[left..].to_i + a).to_s if left
      end
    end
    number
  end

  def self.part1(input)
    numbers = parse(input)
    #p reduce_number(numbers[0])
    #reduce_number("[#{numbers[0]}, #{numbers[1]}]")
    number = numbers.reduce { |a, b| reduce_number("[#{a}, #{b}]") }
    compute_magnitude(eval(number))
  end

  def self.part2(input)
    numbers = parse(input)
    numbers.permutation(2).map { |a,b| compute_magnitude(eval(reduce_number("[#{a}, #{b}]"))) }.max
  end
end

=begin

"[[[[4, 0], [5, 4]], [[7, 0], [15, 5]]], [10, [[0, [11, 3]], [[6, 3], [8, 8]]]]]"


# [[[0,[4,5]],[0,0]],[[[4,5],[2,6]],[9,5]]]
+ [7,[[[3,7],[4,3]],[[6,3],[8,8]]]]
explode :  [[[[4,0],[5,0]],[[[4,5],[2,6]],[9,5]]],[7,[[[3,7],[4,3]],[[6,3],[8,8]]]]]
explode :  [[[[4,0],[5,4]],[[0,[7,6]],[9,5]]],[7,[[[3,7],[4,3]],[[6,3],[8,8]]]]]
explode :  [[[[4,0],[5,4]],[[7,0],[15,5]]],[7,[[[3,7],[4,3]],[[6,3],[8,8]]]]]
explode :  [[[[4,0],[5,4]],[[7,0],[15,5]]],[10,[[0,[11,3]],[[6,3],[8,8]]]]]
explode :  [[[[4,0],[5,4]],[[7,0],[15,5]]],[10,[[11,0],[[9,3],[8,8]]]]]
explode :  [[[[4,0],[5,4]],[[7,0],[15,5]]],[10,[[11,9],[0,[11,8]]]]]
explode :  [[[[4,0],[5,4]],[[7,0],[15,5]]],[10,[[11,9],[11,0]]]]
  split :  [[[[4,0],[5,4]],[[7,0],[[7,8],5]]],[10,[[11,9],[11,0]]]]
explode :  [[[[4,0],[5,4]],[[7,7],[0,13]]],[10,[[11,9],[11,0]]]]
  split :  [[[[4,0],[5,4]],[[7,7],[0,[6,7]]]],[10,[[11,9],[11,0]]]]
explode :  [[[[4,0],[5,4]],[[7,7],[6,0]]],[17,[[11,9],[11,0]]]]
  split :  [[[[4,0],[5,4]],[[7,7],[6,0]]],[[8,9],[[11,9],[11,0]]]]
  split :  [[[[4,0],[5,4]],[[7,7],[6,0]]],[[8,9],[[[5,6],9],[11,0]]]]
explode :  [[[[4,0],[5,4]],[[7,7],[6,0]]],[[8,14],[[0,15],[11,0]]]]
  split :  [[[[4,0],[5,4]],[[7,7],[6,0]]],[[8,[7,7]],[[0,15],[11,0]]]]
  split :  [[[[4,0],[5,4]],[[7,7],[6,0]]],[[8,[7,7]],[[0,[7,8]],[11,0]]]]
explode :  [[[[4,0],[5,4]],[[7,7],[6,0]]],[[8,[7,7]],[[7,0],[19,0]]]]
  split :  [[[[4,0],[5,4]],[[7,7],[6,0]]],[[8,[7,7]],[[7,0],[[9,10],0]]]]
explode :  [[[[4,0],[5,4]],[[7,7],[6,0]]],[[8,[7,7]],[[7,9],[0,10]]]]
  split :  [[[[4,0],[5,4]],[[7,7],[6,0]]],[[8,[7,7]],[[7,9],[0,[5,5]]]]]
explode :  [[[[4,0],[5,4]],[[7,7],[6,0]]],[[8,[7,7]],[[7,9],[5,0]]]]
= [[[[4,0],[5,4]],[[7,7],[6,0]]],[[8,[7,7]],[[7,9],[5,0]]]]
=end