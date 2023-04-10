require './spec/spec_helper'

class Game
  def start
    main_menu
    play_game
  end

  def main_menu
    # input = ""
    p "Welcome to BATTLESHIP"
    p "Enter p to play. Enter q to quit."
    input = get.chomp.downcase
    if input == "p"
      play_game
    else
      "Press 'p' when ready to play"
    end
    
  end

  def play_game

  end

end