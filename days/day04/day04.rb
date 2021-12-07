module Day04
  def self.parse(input)
    draw, *boards = input.split("\n\n")
    draw = draw.split(',').map(&:to_i)
    boards = boards.map do |board|
      board.split("\n").map { |line| line.split.map(&:to_i) }
    end
    [draw, boards]
  end

  def self.compute_score(board, number)
    board.flatten.reject { |values| values == 'X' }.sum * number
  end

  def self.compute_winners(boards, number)
    winners = []
    boards.each_with_index do |board, index|
      row = board.index { |line| line.include?(number) }
      next if row.nil?

      column = board[row].index(number)
      board[row][column] = 'X'
      winners << index if board[row].count('X') == 5 || board.transpose[column].count('X') == 5
    end
    winners
  end

  def self.part1(input)
    draw, boards = parse(input)

    draw.each do |number|
      winners = compute_winners(boards, number)
      return compute_score(boards[winners.first], number) if winners.any?
    end
  end

  def self.part2(input)
    draw, boards = parse(input)

    draw.each do |number|
      winners = compute_winners(boards, number)
      return compute_score(boards.first, number) if winners.any? && boards.size == 1

      winners.sort.reverse.each do |index|
        boards.delete_at(index)
      end
    end
  end
end
