module Day13
  def self.parse(input)
    dots, folds = input.split("\n\n")
    dots = dots.split("\n").map { |line| line.split(',').map(&:to_i) }
    folds = folds.split("\n").map do |line|
      axe, coordinate = line.split[-1].split('=')
      coordinate = coordinate.to_i
      [axe, coordinate]
    end
    [dots, folds]
  end

  def self.fold(dots, axe, coordinate)
    case axe
    when 'y'
      dots.map! do |x, y|
        y > coordinate ? [x, 2 * coordinate - y] : [x, y]
      end
    when 'x'
      dots.map! do |x, y|
        x > coordinate ? [2 * coordinate - x, y] : [x, y]
      end
    end
    dots.uniq!
  end


  def self.part1(input)
    dots, folds = parse(input)
    axe, coordinate = folds.first

    fold(dots, axe, coordinate).size
  end

  def self.part2(input)
    dots, folds = parse(input)
    folds.map do |axe, coordinate|
      fold(dots, axe, coordinate)
    end
    max_x, max_y = dots.transpose.map(&:max)
    transparent = Array.new(max_y + 1) { Array.new(max_x + 1, ' ') }
    dots.each { |x, y| transparent[y][x] = '#' }
    puts
    puts transparent.map(&:join)
    transparent
  end
end
