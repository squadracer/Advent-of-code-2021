module Day10
  def self.parse(input)
    input.split
  end

  CHARSET = { ']' => '[',
              ')' => '(',
              '}' => '{',
              '>' => '<' }
  def self.part1(input)
    lines = parse(input)
    values = { ']' => 57,
      ')' => 3,
      '}' => 1197,
      '>' => 25137 }
    score = 0
    lines.each do |line|
      stack = []
      line.each_char do |c|
        if CHARSET[c]
          if stack.last == CHARSET[c]
            stack.pop
          else
            score += values[c]
            break
          end
        else
          stack << c
        end
      end
    end
    score
  end

  def self.part2(input)
    lines = parse(input)
    values = { '[' => 2,
      '(' => 1,
      '{' => 3,
      '<' => 4 }
    score = []
    lines.each do |line|
      stack = []
      valid = true
      line.each_char do |c|
        if CHARSET[c]
          if stack.last == CHARSET[c]
            stack.pop
          else
            valid = false
            break
          end
        else
          stack << c
        end
      end
      if valid
        score << stack.reverse.reduce(0) { |a, b| a * 5 + values[b] }
      end
    end
    score.sort[score.size / 2]
  end
end
