require './days/day19/day19'
RSpec.describe Day19, '#solve' do
  $VERBOSE = nil
  it 'match 2 identical scanners' do
    s1 = Day19::Scanner.new(0, [[1, 2, 3]])
    s2 = Day19::Scanner.new(1, [[1, 2, 3]])
    Day19::Scanner::BEACONS_COUNT=1
    expect(s1.match(s2)).to eq true
  end

  it 'match a scanners with another beacon' do
    s1 = Day19::Scanner.new(0, [[1, 2, 3]])
    s2 = Day19::Scanner.new(1, [[1, 2, 3], [2000, 5, 6]])
    Day19::Scanner::BEACONS_COUNT=1
    expect(s1.match(s2)).to eq true
  end

  it 'match a scanners with each another another beacon' do
    s1 = Day19::Scanner.new(0, [[1, 2, 3], [99, 6, 7]])
    s2 = Day19::Scanner.new(1, [[1, 2, 3], [2000, 5, 6]])
    Day19::Scanner::BEACONS_COUNT=1
    expect(s1.match(s2)).to eq true
  end

  it 'does not match a scanners with each another another beacon' do
    s1 = Day19::Scanner.new(0, [[1, 2, 3], [99, 6, 7]])
    s2 = Day19::Scanner.new(1, [[1, 2, 3], [2000, 5, 6]])
    Day19::Scanner::BEACONS_COUNT=2
    expect(s1.match(s2)).to eq false
  end

  it 'match a scanners with a translated beacon' do
    s1 = Day19::Scanner.new(0, [[1, 2, 3], [99, 6, 7]])
    s2 = Day19::Scanner.new(1, [[100, 101, 102], [2000, 5, 6]])
    Day19::Scanner::BEACONS_COUNT=1
    expect(s1.match(s2)).to eq true
  end

  it 'match a scanners with 2 beacons with only a translation' do
    s1 = Day19::Scanner.new(0, [[1, 2, 3], [99, 6, 7]])
    s2 = Day19::Scanner.new(1, [[100, 101, 102], [198, 105, 106]])
    Day19::Scanner::BEACONS_COUNT=2
    expect(s1.match(s2)).to eq true
  end

  it 'match a scanners with 2 beacons with only a simple rotation' do
    s1 = Day19::Scanner.new(0, [[134, 12341, 1341234], [1, 2, 3], [0, 0, 0]])
    s2 = Day19::Scanner.new(1, [[0, 0, 0], [2, -1, 3]])
    Day19::Scanner::BEACONS_COUNT=2
    expect(s1.match(s2)).to eq true
  end

  it 'does not a scanners with 2 beacons with only a simple rotations' do
    s1 = Day19::Scanner.new(0, [[134, 12341, 1341234], [1, 2, 3], [0, 0, 0]])
    s2 = Day19::Scanner.new(1, [[0, 0, 0], [2, -1, 5]])
    Day19::Scanner::BEACONS_COUNT=2
    expect(s1.match(s2)).to eq false
  end

  it 'match a scanners with another beacon' do
    s1 = Day19::Scanner.new(0, [[1, 2, 3]])
    s2 = Day19::Scanner.new(1, [[2, 3, 4], [2000, 5, 6]])
    s3 = Day19::Scanner.new(2, [[4, 5, 6], [2000, 5, 6]])
    Day19::Scanner::BEACONS_COUNT=1
    expect(s1.match(s2)).to eq true
    expect(s2.match(s3)).to eq true
    expect(s1.scanner_position).to eq [0, 0, 0]
    expect(s2.scanner_position).to eq [1, 1, 1]
    expect(s3.scanner_position).to eq [3, 3, 3]
  end

  it 'first 2 scanners match' do
    str = File.open('./days/day19/sample').read
    s1, s2, *other = Day19.parse(str)
    expect(s1.match(s2)).to eq true
  end

  it 'part 1 works with sample' do
    str = File.open('./days/day19/sample').read
    expect(Day19.part1(str)).to eq 123
  end

  it 'part 1 works with input' do
    str = File.open('./days/day19/input').read
    expect(Day19.part1(str)).to eq 719
  end

  it 'part 2 works with sample' do
    str = File.open('./days/day19/sample').read
    expect(Day19.part2(str)).to eq 3621
  end

  it 'part 2 works with input' do
    str = File.open('./days/day19/input').read
    expect(Day19.part2(str)).to eq 4393
  end
end
