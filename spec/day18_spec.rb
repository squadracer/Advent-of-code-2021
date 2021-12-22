require './days/day18/day18'
RSpec.describe Day18, '#solve' do
  it 'part 1 works with sample' do
    str = File.open('./days/day18/sample').read
    expect(Day18.part1(str)).to eq 4140
  end

  it 'part 1 works with input' do
    str = File.open('./days/day18/input').read
    expect(Day18.part1(str)).to eq 3884
  end

  it 'part 2 works with sample' do
    str = File.open('./days/day18/sample').read
    expect(Day18.part2(str)).to eq 3993
  end

  it 'part 2 works with input' do
    str = File.open('./days/day18/input').read
    expect(Day18.part2(str)).to eq 4595
  end
end
