require './days/day22/day22'
RSpec.describe Day22, '#solve' do
  it 'part 1 works with sample' do
    str = File.open('./days/day22/sample').read
    expect(Day22.part1(str)).to eq 474140
  end

  it 'part 1 works with input' do
    str = File.open('./days/day22/input').read
    expect(Day22.part1(str)).to eq 580810
  end

  it 'part 2 works with sample' do
    str = File.open('./days/day22/sample').read
    expect(Day22.part2(str)).to eq 2758514936282235
  end

  it 'part 2 works with input' do
    str = File.open('./days/day22/input').read
    expect(Day22.part2(str)).to eq 1265621119006734
  end
end
