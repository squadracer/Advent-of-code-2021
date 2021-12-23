require './days/day19/day19'
RSpec.describe Day19, '#solve' do
  it 'part 1 works with sample' do
    str = File.open('./days/day19/sample').read
    expect(Day19.part1(str)).to eq 79
  end

  it 'part 1 works with input' do
    str = File.open('./days/day19/input').read
    expect(Day19.part1(str)).to eq 313
  end

  it 'part 2 works with sample' do
    str = File.open('./days/day19/sample').read
    expect(Day19.part2(str)).to eq 3621
  end

  it 'part 2 works with input' do
    str = File.open('./days/day19/input').read
    expect(Day19.part2(str)).to eq 10656
  end
end
