require './days/day17/day17'
RSpec.describe Day17, '#solve' do
  it 'part 1 works with sample' do
    str = File.open('./days/day17/sample').read
    expect(Day17.part1(str)).to eq 45
  end

  it 'part 1 works with input' do
    str = File.open('./days/day17/input').read
    expect(Day17.part1(str)).to eq 5995
  end

  it 'part 2 works with sample' do
    str = File.open('./days/day17/sample').read
    expect(Day17.part2(str)).to eq 112
  end

  it 'part 2 works with input' do
    str = File.open('./days/day17/input').read
    expect(Day17.part2(str)).to eq 3202
  end
end
