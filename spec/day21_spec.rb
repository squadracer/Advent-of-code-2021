require './days/day21/day21'
RSpec.describe Day21, '#solve' do
  it 'part 1 works with sample' do
    str = File.open('./days/day21/sample').read
    expect(Day21.part1(str)).to eq 739785
  end

  it 'part 1 works with input' do
    str = File.open('./days/day21/input').read
    expect(Day21.part1(str)).to eq 604998
  end

  it 'part 2 works with sample' do
    str = File.open('./days/day21/sample').read
    expect(Day21.part2(str)).to eq 444356092776315
  end

  it 'part 2 works with input' do
    str = File.open('./days/day21/input').read
    expect(Day21.part2(str)).to eq 157253621231420
  end
end
