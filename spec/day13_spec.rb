require './days/day13/day13'
RSpec.describe Day13, '#solve' do
  it 'part 1 works with sample' do
    str = File.open('./days/day13/sample').read
    expect(Day13.part1(str)).to eq 17
  end

  it 'part 1 works with input' do
    str = File.open('./days/day13/input').read
    expect(Day13.part1(str)).to eq 847
  end

  xit 'part 2 works with sample' do
    str = File.open('./days/day13/sample').read
    expect(Day13.part2(str)).to eq [["#", "#", "#", "#", "#"], ["#", " ", " ", " ", "#"], ["#", " ", " ", " ", "#"], ["#", " ", " ", " ", "#"], ["#", "#", "#", "#", "#"]]
  end

  it 'part 2 works with input' do
    str = File.open('./days/day13/input').read
    expect(Day13.part2(str))
  end
end
