module Day14
  def self.parse(input)
    template, rules = input.split("\n\n")
    rules = rules.split("\n").to_h { |line| line.split(' -> ') }
    rules.transform_keys!(&:chars)
    [template, rules]
  end

  def self.polymerize(polymer, rules)
    polymer[0] + polymer.chars.each_cons(2).map { |pair| rules[pair] + pair[1] }.join
  end

  def self.part1(input)
    template, rules = parse(input)
    10.times do
      template = polymerize(template, rules)
    end
    template.chars.tally.values.minmax.reduce(:-).abs
  end

  def self.solve(pair, rules, steps)
    return pair.tally if steps.zero?

    if @memoization[[pair, steps]].nil?
      a = solve([pair[0], rules[pair]], rules, steps - 1)
      b = solve([rules[pair], pair[1]], rules, steps - 1)
      concat = Hash.new(0)
      a.each do |key, value|
        concat[key] += value
      end
      b.each do |key, value|
        concat[key] += value
      end
      concat[rules[pair]] -= 1
      @memoization[[pair, steps]] = concat
    else
      @memoization[[pair, steps]]
    end
  end

  def self.part2(input, nb_steps = 40)
    template, rules = parse(input)
    @memoization = {}
    result = {}
    template.chars.each_cons(2) do |pair|
      solve(pair, rules, nb_steps).each do |key, value|
        result[key] ? result[key] += value : result[key] = value
      end
    end
    result.values.minmax.reduce(:-).abs
  end

  def self.rules_v2(rules)
    rules.to_h { |key, value| [key, [[key[0], value], [value, key[1]]]] }
  end

  def self.step(polymer, rules)
    # polymer = hash[pair]
    next_step = Hash.new(0)
    polymer.each do |key, value|
      pairs = rules[key]
      next_step[pairs[0]] += value
      next_step[pairs[1]] += value
    end
    next_step
  end

  def self.part2_simple(input, nb_steps = 40)
    template, rules = parse(input)
    template = template.chars.each_cons(2).tally
    rules = rules_v2(rules)
    nb_steps.times { template = step(template, rules) }
    result = Hash.new(0)
    template.each do |key, value|
      result[key[0]] += value
      result[key[1]] += value
    end
    result.transform_values! { |val| (val + 1) / 2 }
    result.values.minmax.reduce(:-).abs
  end

  def self.part2_matrix(input, nb_steps = 40)
    require 'matrix'

    template, rules = parse(input)
    rules = rules_v2(rules)
    index = rules.keys
    
    #
    matrix = Array.new(index.size) { Array.new(index.size, 0) }
    rules.each do |key, values|
      matrix[index.index(key)][index.index(values[0])] += 1
      matrix[index.index(key)][index.index(values[1])] += 1
    end

    
    vector = index.map { |pair| template.chars.each_cons(2).count(pair) }
    result_pairs = Matrix[vector] * (Matrix.rows(matrix)**nb_steps)
    result = Hash.new(0)
    index.zip(result_pairs).each { |pair, count| result[pair[0]] += count; result[pair[1]] += count}
    result.transform_values! { |val| (val + 1) / 2 }
    result.values.minmax.reduce(:-).abs
  end
end
