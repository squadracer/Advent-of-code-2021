require './days/day16/day16'
RSpec.describe Day16, '#solve' do
  it 'part 1 works with sample' do
    str = File.open('./days/day16/sample').read
    expect(Day16.part1(str)).to eq 20
  end

  it 'part 1 works with input' do
    str = File.open('./days/day16/input').read
    expect(Day16.part1(str)).to eq 871
  end

  it 'part 2 works with sample' do
    str = File.open('./days/day16/sample').read
    expect(Day16.part2(str)).to eq 1
  end

  it 'part 2 works with input' do
    str = File.open('./days/day16/input').read
    expect(Day16.part2(str)).to eq 68703010504
  end
end
