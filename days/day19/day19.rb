module Day19
  def self.parse(input)
    input.split("\n\n").map do |scanner|
      points = scanner.split("\n")[1..]
      points.map { |point| point.split(',').map(&:to_i) }
    end
  end

  def self.generate_distance(scanner)
    scanner.map do |point1_x, point1_y, point1_z|
      scanner.map do |point2_x, point2_y, point2_z|
        (point1_x - point2_x)**2 + (point1_y - point2_y)**2 + (point1_z - point2_z)**2
      end
    end
  end

  def self.correspondance(distances1, distances2)
    corresp = {}
    common = distances1.product(distances2).filter do |a, b|
      inter = (a & b)
      next if inter.size < 12

      inter.each { |c| corresp[a.index(c)] = b.index(c) }
    end
    common.size >= 12 ? corresp : nil
  end

  def self.rotation_matrix(scanner1, scanner2)
    vect1 = scanner1.transpose.map { |a, b| b - a }
    vect2 = scanner2.transpose.map { |a, b| b - a }

    matrix = Array.new(3) { Array.new(3, 0) }
    vect2.each_with_index do |coord, i|
      i2 = vect1.index(coord)
      i2 ? matrix[i][i2] = 1 : matrix[i][vect1.index(-coord)] = -1
    end
    matrix
  end

  def self.rotate_with_matrix(scanner, rotation)
    (Matrix[*scanner] * Matrix[*rotation]).to_a
  end

  def self.translation(destination_point, source_point)
    source_point.zip(destination_point).map { |a, b| b - a }
  end

  def self.translate(scanner, translation)
    scanner.map { |coords| coords.zip(translation).map { |a, b| a + b } }
  end

  def self.part1(input)
    require 'matrix'
    reference, *scanners = parse(input)
    aligned = [reference]
    aligned_count = 0
    coords = [[0, 0, 0]]
    while scanners.any?
      current = aligned[aligned_count]
      distances_current = generate_distance(current)
      remove = []
      scanners.each do |scanner|
        distances_scanner = generate_distance(scanner)
        h = correspondance(distances_current, distances_scanner)
        if h
          remove << scanner
          scan1 = h.keys[1..2]
          scan2 = h.values_at(*scan1)
          rotation_matrix = rotation_matrix(scan1.map{|index|current[index]}, scan2.map{|index|scanner[index]})
          scanner=rotate_with_matrix(scanner, rotation_matrix)
          translation = translation(current[scan1.first], scanner[scan2.first])
          coords << translation
          scanner = translate(scanner, translation)
          aligned << scanner
        end
      end
      scanners -= remove
      aligned_count += 1
    end
    aligned.flatten(1).uniq.count
  end

  def self.part2(input)
    require 'matrix'
    reference, *scanners = parse(input)
    aligned = [reference]
    aligned_count = 0
    coords = [[0, 0, 0]]
    while scanners.any?
      current = aligned[aligned_count]
      distances_current = generate_distance(current)
      remove = []
      scanners.each do |scanner|
        distances_scanner = generate_distance(scanner)
        h = correspondance(distances_current, distances_scanner)
        if h
          remove << scanner
          scan1 = h.keys[1..2]
          scan2 = h.values_at(*scan1)
          rotation_matrix = rotation_matrix(scan1.map{|index|current[index]}, scan2.map{|index|scanner[index]})
          scanner=rotate_with_matrix(scanner, rotation_matrix)
          translation = translation(current[scan1.first], scanner[scan2.first])
          coords << translation
          scanner = translate(scanner, translation)
          aligned << scanner
        end
      end
      scanners -= remove
      aligned_count += 1
    end
    coords.combination(2).map {|a,b| a.zip(b).sum{|c,d| (d-c).abs} }.max
  end
end
