module Day21
  def self.parse(input)
    input.split("\n").map { |line| line.split[-1].to_i - 1 }
  end

  def self.part1(input)
    player_position = parse(input)
    player_scores = [0, 0]
    turng = [0, 1].cycle
    dice = (1..100).cycle
    dice_rolled = 0
    while player_scores.max < 1000
      turn = turng.next
      player_position[turn] += dice.next + dice.next + dice.next
      dice_rolled += 3
      player_position[turn] = player_position[turn] % 10
      player_scores[turn] += player_position[turn] + 1
    end
    player_scores.min * dice_rolled
  end

  def self.part2(input)
    player_position = parse(input)
    # player data
    # position -> { count, score }
    players_univers = [ Hash.new(0), Hash.new(0) ]
    players_univers[0][{position: player_position[0],score: 0}] = 1
    players_univers[1][{position: player_position[1],score: 0}] = 1

    players_wins = [0, 0]
    turng = [0, 1].cycle
    facets = [1, 2, 3]
    dice_results = facets.repeated_permutation(3).map(&:sum).tally
    while players_univers.any?(&:any?)
      turn = turng.next
      # players_univers[turn] = play(players_univers[turn])
      new_player_univers = Hash.new(0)
      players_univers[turn].each do |univers, univers_count|
        dice_results.each do |score, score_count|
          position = (univers[:position] + score) % 10
          new_player_univers[{position: position, score: univers[:score] + position + 1}] += univers_count * score_count
        end
      end
      other_player_univers_count = players_univers[1 - turn].values.sum
      players_univers[turn] = new_player_univers.filter_map do |univers, univers_count|
        if univers[:score] >= 21
          players_wins[turn] += univers_count * other_player_univers_count
          nil
        else
          [univers, univers_count]
        end
      end.to_h
    end
    players_wins.max
  end
end
