require_relative 'board'
require_relative 'player'
class Game
  include Board
  attr_accessor :first_player, :second_player

  def start_game
    2.times do |player_no|
      player_info(player_no + 1)
    end
    user_choice
  end

  def player_info(player_no)
    name = player_name(player_no)
    symbol = player_symbol(player_no)
    validate_name(name) if player_no == 2
    validate_symbol(player_no, symbol)
    if player_no == 1
      self.first_player = Player.new(name, symbol)
    else
      self.second_player = Player.new(name, symbol)
    end
  end

  def player_name(player_no)
    puts "What would you like to call your #{player_no} player?"
    gets.chomp
  end

  def player_symbol(player_no)
    puts "How would you like to represent your #{player_no} player?"
    gets.chomp
  end

  def user_choice
    replace_indices
    user_input_counter = 0
    [first_player, second_player].cycle.each do |player|
      user_input_counter += 1
      choices_finished if user_input_counter > 9
      puts "#{player.name.capitalize} choose a number from 1-9 to mark your position"
      index = gets.chomp
      re_arrange_board(index, player)
    end
  end

  def choices_finished
    puts "Its a draw."
    exit!
  end

  def reenter_user_choice(player)
    puts "#{player.name.capitalize}, the number you have choosen is either out of range or already been used. choose a number from 1-9 to mark your position"
    index = gets.chomp
    re_arrange_board(index, player)
  end

  def re_arrange_board(index, player)
    if (1..9).to_a.include?(index.to_i)
      replace_indices(player, index)
    else
      reenter_user_choice(player)
    end
  end

  def replace_indices(player = nil, user_choice = nil)
    @indices = user_choice.nil? ? (1..9).to_a : @indices
    unless user_choice.nil?
      index = @indices.index(user_choice.to_i)
      if index.nil?
        puts "Please select another number.The number you previously entered has already been used."
        reenter_user_choice(player)
      end
      @indices[index] = player.symbol
    end
    player_board(@indices, player, user_choice)
  end

  def replay
    start_game
  end

  private

  def validate_name(name)
    if first_player.name == name
      puts "The name has already been taken by previous player"
      player_name(2)
    end
  end

  def validate_symbol(player_no, symbol)
    validate_symbol_length(player_no, symbol)
    if player_no == 2 && first_player.symbol == symbol
      puts "The name has already been taken by previous player"
      player_symbol(2)
    end
  end

  def validate_symbol_length(player_no, symbol)
    if symbol.length != 1
      puts "You can only enter single letter."
      player_symbol(player_no)
    end
  end
end

game = Game.new
game.start_game

