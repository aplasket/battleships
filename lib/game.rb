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
    comp_cruiser = Ship.new("Cruiser", 3)
    comp_submarine = Ship.new("Submarine", 2)
    computer_placement(comp_cruiser)
    computer_placement(comp_submarine)
    p @computer.board.render(true)
  end
  
  def valid_coordinates(ship)
    coordinate_array = []
    until @computer.board.valid_placement?(ship, coordinate_array) do
      coordinate_array = @computer.board.cells.keys.sample(ship.length)
    end
    coordinate_array
  end
  
  def computer_placement(ship)
    @computer.board.place(ship, valid_coordinates(ship))
  end
  
end

# turns
# end game