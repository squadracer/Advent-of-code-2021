require './days/day07/day07'
RSpec.describe Day07, '#solve' do
  it 'part 1 works with sample' do
    str = File.open('./days/day07/sample').read
    expect(Day07.part1(str)).to eq 37
  end

  it 'part 1 works with input' do
    str = File.open('./days/day07/input').read
    expect(Day07.part1(str)).to eq 344535
  end

  it 'part 2 works with sample' do
    str = File.open('./days/day07/sample').read
    expect(Day07.part2opti(str)).to eq 168
  end

  it 'part 2 works with input' do
    str = File.open('./days/day07/input').read
    expect(Day07.part2opti(str)).to eq 95581659
  end
end
