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
    puts "Welcome to BATTLESHIP"
    puts "Enter p to play. Enter q to quit."
    input = gets.chomp.downcase
    if input == "p"
      puts " ----------------------"
      puts "Let's play!"
      play_game
    elsif input == "q"
      puts "You are quitting!"
      # quit game, clear the board
    else
      puts "Please press 'p' or 'q' to continue"
    end
  end

  def play_game
    comp_cruiser = Ship.new("Cruiser", 3)
    comp_submarine = Ship.new("Submarine", 2)
    computer_placement(comp_cruiser)
    computer_placement(comp_submarine)

    player_cruiser = Ship.new("Cruiser", 3)
    player_submarine = Ship.new("Submarine", 2)
    lists_rules
    puts "Let's place your Cruiser! Type in 3 valid coordinates in a horizonal or vertical row.\n Example: A1 A2 A3:"
    player_placement(player_cruiser)
    puts
    puts "Let's place your Submarine! Type in 2 valid coordinates in a horizonal or vertical row.\n Example: B1 B2:"
    player_placement(player_submarine)
    puts 
    puts "Time to start the battle!"
    play_turn
  end
  
  def lists_rules
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    puts "The Cruiser is three units long and the Submarine is two units long."
    puts 
    puts "Rules for Battleship placements:\n" + 
          " - The number of coordinates entered must equal the ship's unit length described above\n" +
          " - All coordinates must be entered in consecutive and alphabetical order\n" +
          " - An example of invalid coordinates: A2 B3 C4 (diagonal placement is not allowed)\n" +
          " - Another example of invalid coordinates: A3 A2 A1\n" +
          " - Additionally, the 2 ships coordinates cannot overlap"
    puts
    puts "Here is how your board looks currently!"
    puts @player.board.render(true)
    puts
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
  
  def player_placement(ship)
    input = gets.chomp.upcase
    coordinate_array = input.split(" ")
    until @player.board.valid_placement?(ship, coordinate_array) do
      puts "Those are invalid coordinates. Please try again:"
      input = gets.chomp.upcase
      coordinate_array = input.split(" ")
    end
    puts
    puts "Huzzah! You've placed your #{ship.name}!"
    @player.board.place(ship, coordinate_array)
    puts @player.board.render(true)
  end

  def play_turn
    puts '=============COMPUTER BOARD============='
    puts @computer.board.render
    puts '==============PLAYER BOARD=============='
    puts @player.board.render(true)
    puts 'It is your turn to pick one coordinate to fire upon:'
    player_fire_upon
    computer_fire_upon
  end
  
  def player_fire_upon
    input = gets.chomp.upcase
    until @computer.board.valid_coordinate?(input) do
      puts "That is an invalid coordinate. Please try again:"
      input = gets.chomp.upcase
    end
    @computer.board.cells[input].fire_upon
  end

  def computer_fire_upon
    coordinate_array = []
    until @player.board.valid_coordinate?(coordinate_array) && !@player.board.cells[coordinate_array].fired_upon? do
      coordinate_array = @computer.board.cells.keys.sample
    end
    @player.board.cells[coordinate_array].fire_upon
  end
end

# turns
# end game