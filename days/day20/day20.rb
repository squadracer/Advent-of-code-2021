module Day20
  def self.parse(input)
    translation, image = input.split("\n\n")
    image = image.split("\n")
    [translation, image]
  end

  def self.enhance(image, translation, border)
    image = [border * image[0].size] * 2 + image + [border * image[0].size] * 2
    image.map! { |line| border * 2 + line + border * 2 }
    destination = Marshal.load(Marshal.dump(image))
    neighbours = [[-1, -1], [-1, 0], [-1, 1],
                  [0, -1], [0, 0], [0, 1],
                  [1, -1], [1, 0], [1, 1]]
    (1...image.size - 1).each do |y|
      (1...image[0].size - 1).each do |x|
        index = neighbours.map { |dy, dx| image[y + dy][x + dx] }.join.tr('.#', '01').to_i(2)
        destination[y][x] = translation[index]
      end
    end
    border = (border == '.' ? translation[0] : translation[-1])
    destination = destination[1..-2].map { |line| line[1..-2] }
    [destination, border]
  end

  def self.solve(input, steps)
    translation, image = parse(input)
    border = '.'
    steps.times do
      image, border = enhance(image, translation, border)
    end
    image.sum { |line| line.count('#') }
  end

  def self.part1(input)
    solve(input, 2)
  end

  def self.part2(input)
    solve(input, 50)
  end
end
