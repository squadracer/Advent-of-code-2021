require './days/day09/day09'
RSpec.describe Day09, '#solve' do
  it 'part 1 works with sample' do
    str = File.open('./days/day09/sample').read
    expect(Day09.part1(str)).to eq 15
  end

  it 'part 1 works with input' do
    str = File.open('./days/day09/input').read
    expect(Day09.part1(str)).to eq 541
  end

  it 'part 2 works with sample' do
    str = File.open('./days/day09/sample').read
    expect(Day09.part2(str)).to eq 1134
  end

  it 'part 2 works with input' do
    str = File.open('./days/day09/input').read
    expect(Day09.part2(str)).to eq 847504
  end
end
