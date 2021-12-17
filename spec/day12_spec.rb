require './days/day12/day12'
RSpec.describe Day12, '#solve' do
  it 'part 1 works with sample' do
    str = File.open('./days/day12/sample').read
    expect(Day12.part1(str)).to eq 10
  end

  it 'part 1 works with input' do
    str = File.open('./days/day12/input').read
    expect(Day12.part1(str)).to eq 4549
  end

  it 'part 2 works with sample' do
    str = File.open('./days/day12/sample').read
    expect(Day12.part2(str)).to eq 36
  end

  it 'part 2 works with input' do
    str = File.open('./days/day12/input').read
    expect(Day12.part2(str)).to eq 120535
  end
end
