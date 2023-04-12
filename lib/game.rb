class Game
  attr_reader :computer,
              :player

  def initialize
    @computer = Computer.new
    @player = Player.new
    @player_sunken_ships = 0
    @computer_sunken_ships = 0
  end

  def start
    main_menu
  end

  def main_menu
    sleep(1)
    # puts <<-'EOF'
    #                          __      __       .__                               
    #                         /  \    /  \ ____ |  |   ____  ____   _____   ____  
    #                         \   \/\/   // __ \|  | _/ ___\/  _ \ /     \_/ __ \ 
    #                          \        /\  ___/|  |_\  \__(  <_> )  Y Y  \  ___/ 
    #                           \__/\  /  \___  >____/\___  >____/|__|_|  /\___  >
    #                                \/       \/          \/            \/     \/ 

    # EOF
    # sleep(1)
    # puts <<-'EOF'
    #                                            __          
    #                                          _/  |_  ____  
    #                                          \   __\/  _ \ 
    #                                           |  | (  <_> )
    #                                           |__|  \____/ 
                 
    # EOF
    # sleep(1)
    # puts <<-'EOF'
    # __________    ___________________________.____     ___________ _________ ___ ___ ._____________ 
    # \______   \  /  _  \__    ___/\__    ___/|    |    \_   _____//   _____//   |   \|   \______   \
    #  |    |  _/ /  /_\  \|    |     |    |   |    |     |    __)_ \_____  \/    ~    \   ||     ___/
    #  |    |   \/    |    \    |     |    |   |    |___  |        \/        \    Y    /   ||    |    
    #  |______  /\____|__  /____|     |____|   |_______ \/_______  /_______  /\___|_  /|___||____|    
    #         \/         \/                            \/        \/        \/       \/               

    # EOF
    # sleep(2)
    # puts <<-'EOF'
    #                                               __/___            
    #                                         _____/______|           
    #                                 _______/_____\_______\_____     
    #                                 \              < < <       |    
    #                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    # EOF
    # sleep(2)
    # puts <<-'EOF'
    #                                             |    |    |                 
    #                                             )_)  )_)  )_)              
    #                                           )___))___))___)\            
    #                                           )____)____)_____)\\
    #                                         _____|____|____|____\\\__
    #                               ---------\                   /---------
    #                                   ^^^^^ ^^^^^^^^^^^^^^^^^^^^^
    #                                     ^^^^      ^^^^     ^^^    ^^
    #                                           ^^^^      ^^^

    # EOF
    # sleep(2)
    # puts "
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    











    












    
    
    
    
    
    
    
    
    
    
    
    # "
    
    # sleep(3)
    # puts "ARRRRR MATEY!" 
    # sleep(2)
    # puts "Are you ready to play?"
    # sleep(2)
    # puts "Enter 'p' to play..."
    # sleep(1)
    # puts "...and probably lose"
    # sleep(1)
    # puts "OR"
    # sleep(2)
    # puts "Just press 'q' if you are scared" 
    # sleep(2)
    puts "and want to quit..."
    input = gets.chomp.downcase
    if input == "p"
      puts <<-'EOF'
      ---------------------------------------------------------------------
         _      ______ _______ _  _____   _____  _           __     ___ 
        | |    |  ____|__   __( )/ ____| |  __ \| |        /\\ \   / / |
        | |    | |__     | |  |/| (___   | |__) | |       /  \\ \_/ /| |
        | |    |  __|    | |     \___ \  |  ___/| |      / /\ \\   / | |
        | |____| |____   | |     ____) | | |    | |____ / ____ \| |  |_|
        |______|______|  |_|    |_____/  |_|    |______/_/    \_\_|  (_)
                                                                        
      ---------------------------------------------------------------------
      EOF
      sleep(2)
      puts
      puts
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
    puts "First, you must place your Cruiser on the board.\nType in 3 valid coordinates in either a horizontal or vertical row"
    puts "(Coordinates must be in alphabetical and numerical order)"
    puts "Example: A1 A2 A3"
    # puts "Let's place your Cruiser! Type in 3 valid coordinates in a horizonal or vertical row.\n Example: A1 A2 A3:"
    player_placement(player_cruiser)
    puts
    puts "Let's place your Submarine! Type in 2 valid coordinates in a horizonal or vertical row.\n Example: B1 B2:"
    player_placement(player_submarine)
    puts 
    puts "Time to start the battle!"
    play_turn
  end
  
  def lists_rules
    puts "I have laid out my two ships on the grid.\n" +
    "You now need decide on where to put your two ships.\n" +
    "The Cruiser is three units long and the Submarine is two units long.\n"
    puts 
    puts
    puts "Rules for Battleship placements:\n" + 
          " - The number of coordinates entered must equal each of the ship's unit length described above\n" +
          " - All coordinates must be placed horizontally or vertically (no diagonals)\n" +
          " - All coordinates must be entered in numerical and alphabetical order\n" +
          " - No gaps are allowed when picking coordinates\n" +
          " - Ship coordinates cannot overlap with each other\n" +
          " - Examples of invalid coordinates:\n" +
                " - A2 B3 C4 (diagonal placement is not allowed)\n" +
                " - A3 A2 A1 (must be in numerical order)\n" +
          " - Exampes of valid coordinates:\n" +
                " - A4 B4 C5\n" +
                " - D2 D3"
    puts
    puts
    puts "Here is how your board looks currently!"
    puts @player.board.render(true)
    puts
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
  end

  def play_turn
    until there_is_a_winner do
      puts '=============COMPUTER BOARD============='
      puts @computer.board.render
      puts '==============PLAYER BOARD=============='
      puts @player.board.render(true)
      puts 'It is your turn to pick one coordinate to fire upon:'
      player_fire_upon
      computer_fire_upon
    end
    # run_winner_result
  end
  
  def player_fire_upon
    input = gets.chomp.upcase
    until @computer.board.valid_coordinate?(input) && !@computer.board.cells[input].fired_upon? do
      puts "You have either already chosen this coordinate or it is not a valid placement. Please try again:"
      input = gets.chomp.upcase
    end
    @computer.board.cells[input].fire_upon
    player_shot(input)
  end

  def player_shot(input)
    if @computer.board.cells[input].render == "M"
      puts "Your shot on #{input} was a miss!"
    elsif  @computer.board.cells[input].render == "H"
      puts "Your shot on #{input} hit a ship!"
    elsif @computer.board.cells[input].render == "X"
      puts "Your shot on #{input} sunk a ship!"
      @computer_sunken_ships += 1
      if there_is_a_winner == true
        end_game
      end
    end
  end

  def computer_fire_upon
    puts "Now the computer will choose a coordinate to fire upon!"
    coordinate_array = []
    until @player.board.valid_coordinate?(coordinate_array) && !@player.board.cells[coordinate_array].fired_upon? do
      coordinate_array = @computer.board.cells.keys.sample
    end
    @player.board.cells[coordinate_array].fire_upon
    puts "Computer fires upon #{coordinate_array}!"
    computer_shot(coordinate_array)
  end

  def computer_shot(coordinate_array)
    if @player.board.cells[coordinate_array].render == "M"
      puts "The computer's shot on #{coordinate_array} was a miss!"
    elsif  @player.board.cells[coordinate_array].render == "H"
      puts "The computer's shot on #{coordinate_array} hit a ship!"
    elsif @player.board.cells[coordinate_array].render == "X"
      puts "The computer's shot on #{coordinate_array} sunk a ship!"
      @player_sunken_ships += 1
      if there_is_a_winner == true
        end_game
      end
    end
  end

  def there_is_a_winner
    if @computer_sunken_ships == 2
      puts "You have won the game!"
      end_game
    elsif @player_sunken_ships == 2
      puts "You've lost!"
      end_game
    else
      false
    end
  end

  def end_game
    sleep(0.8)
    puts
    puts "This battle has ended!"
    main_menu
  end
end