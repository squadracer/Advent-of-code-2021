require './days/day20/day20'
RSpec.describe Day20, '#solve' do
  it 'part 1 works with sample' do
    str = File.open('./days/day20/sample').read
    expect(Day20.part1(str)).to eq 35
  end

  it 'part 1 works with input' do
    str = File.open('./days/day20/input').read
    expect(Day20.part1(str)).to eq 5486
  end

  it 'part 2 works with sample' do
    str = File.open('./days/day20/sample').read
    expect(Day20.part2(str)).to eq 3351
  end

  it 'part 2 works with input' do
    str = File.open('./days/day20/input').read
    expect(Day20.part2(str)).to eq 20210
  end
end
