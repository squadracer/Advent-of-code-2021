require './days/day08/day08'
RSpec.describe Day08, '#solve' do
  it 'part 1 works with sample' do
    str = File.open('./days/day08/sample').read
    expect(Day08.part1(str)).to eq 26
  end

  it 'part 1 works with input' do
    str = File.open('./days/day08/input').read
    expect(Day08.part1(str)).to eq 318
  end

  it 'part 2 works with sample' do
    str = File.open('./days/day08/sample').read
    expect(Day08.part2(str)).to eq 61229
  end

  it 'part 2 works with input' do
    str = File.open('./days/day08/input').read
    expect(Day08.part2(str)).to eq 996280
  end
end
