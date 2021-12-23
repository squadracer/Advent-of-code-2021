module Day17
  def self.parse(input)
    @x_min, @x_max = input.scan(/x=([-\d]*)..([-\d]*)/)[0].map(&:to_i)
    @y_min, @y_max = input.scan(/y=([-\d]*)..([-\d]*)/)[0].map(&:to_i)
  end

  def self.generate_steps_with_y(y)
    steps = []
    position = 0
    step = 2 * y + 1
    while position > @y_min
      position -= y
      step += 1
      steps << step if position <= @y_max
      y += 1
    end
    steps.uniq.sort
  end

  def self.step_possible?(step)
    
  end

  def self.part1(input)
    parse(input)
    y_max = 0
    (1..@x_max+1).each do |base_x|
      (1..-@y_min+1).each do |vy|
        vx = base_x
        base_y = vy
        summit = 0
        current_x = 0
        current_y = 0
        while current_x <= @x_max && current_y >= @y_min

          if current_x >= @x_min && current_y <= @y_max
            y_max = [summit, y_max].max
            p [y_max, base_x, base_y]
          end

          current_x += vx
          current_y += vy

          summit = [summit, current_y].max

          vx = (vx.positive? ? vx - 1 : vx)
          vy -= 1
        end
      end
    end
    y_max # > 2628
  end

  def self.part2(input)
    parse(input)
    y_max = 0
    count = 0
    (1..@x_max + 1).each do |base_x|
      (@y_min..-@y_min + 1).each do |vy|
        vx = base_x
        base_y = vy
        summit = 0
        current_x = 0
        current_y = 0
        while current_x <= @x_max && current_y >= @y_min

          if current_x >= @x_min && current_y <= @y_max
            count += 1
            break
          end

          current_x += vx
          current_y += vy

          summit = [summit, current_y].max

          vx = (vx.positive? ? vx - 1 : vx)
          vy -= 1
        end
      end
    end
    count # > 2628
  end
end
