require './days/day14/day14'
RSpec.describe Day14, '#solve' do
  it 'part 1 works with sample' do
    str = File.open('./days/day14/sample').read
    expect(Day14.part1(str)).to eq 1588
  end

  it 'part 1 works with input' do
    str = File.open('./days/day14/input').read
    expect(Day14.part1(str)).to eq 2375
  end

  it 'part 2 works with sample' do
    str = File.open('./days/day14/sample').read
    expect(Day14.part2_matrix(str)).to eq 2_188_189_693_529
  end

  it 'part 2 works with input' do
    str = File.open('./days/day14/input').read
    expect(Day14.part2_simple(str)).to eq 1_976_896_901_756
  end
end
