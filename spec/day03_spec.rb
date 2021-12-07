require './days/day03/day03'
RSpec.describe Day03, '#solve' do
  it 'part 1 works with sample' do
    str = File.open('./days/day03/sample').read
    expect(Day03.part1(str)).to eq 198
  end

  it 'part 1 works with input' do
    str = File.open('./days/day03/input').read
    expect(Day03.part1(str)).to eq 3374136
  end

  it 'part 2 works with sample' do
    str = File.open('./days/day03/sample').read
    expect(Day03.part2(str)).to eq 230
  end

  it 'part 2 works with input' do
    str = File.open('./days/day03/input').read
    expect(Day03.part2(str)).to eq 4432698
  end
end
