require './days/day02/day02'
RSpec.describe Day02, '#solve' do
  it 'part 1 works with sample' do
    str = File.open('./days/day02/sample').read
    expect(Day02.part1(str)).to eq 150
  end

  it 'part 1 works with input' do
    str = File.open('./days/day02/input').read
    expect(Day02.part1(str)).to eq 2_215_080
  end

  it 'part 2 works with sample' do
    str = File.open('./days/day02/sample').read
    expect(Day02.part2(str)).to eq 900
  end

  it 'part 2 works with input' do
    str = File.open('./days/day02/input').read
    expect(Day02.part2(str)).to eq 1_864_715_580
  end
end
