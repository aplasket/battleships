require './spec/spec_helper'

class Game
  attr_reader :computer,
              :player

  def initialize(computer, player)
    @computer = computer
    @player = player

  end
  def start
    main_menu
  end

  def main_menu
    p "Welcome to BATTLESHIP"
    p "Enter p to play. Enter q to quit."
    input = gets.chomp.downcase
    if input == "p"
      p "Let's play!"
      play_game
    elsif input == "q"
      p "You are quitting!"
      # quit game, clear the board
    else
      p "Please press 'p' or 'q' to continue"
    end
  end

  def play_game
    # computer placement
    # pick same number as length as ship
    # until @computer.board.valid_placement?(ship, coordinates) do
      arr = @computer.board.cells.to_a.flatten #needs to match length of ship
      p arr.sample
      # board.place_ship(ship, coordinates)
    # end
    # player placement

    # turns
    # end game
  end

end