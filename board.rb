module Board
  WINNING_COMBINATION = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8], [2,4,6]].freeze

  def player_board(indices,player, user_choice)
    puts "#{indices[0]} | #{indices[1]} | #{indices[2]}"
    puts lines
    puts "#{indices[3]} | #{indices[4]} | #{indices[5]}"
    puts lines
    puts "#{indices[6]} | #{indices[7]} | #{indices[8]}"

    check_combination(indices, player) unless user_choice.nil?
  end

  def check_combination(indices, player)
    array_of_combinations_index = (0..8).select { |i| indices[i] == player.symbol }
    array_of_combinations_index.combination(3).each do |combination|
      if WINNING_COMBINATION.include?(combination)
        puts "#{player.name.capitalize} has won the game"
        exit!
      end
    end
  end

  def lines
    "---+---+---"
  end
end