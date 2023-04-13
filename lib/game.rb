class Game
  attr_reader :computer,
              :player

  def initialize
    @computer = Computer.new
    @player = Player.new
    @player_sunken_ships = 0
    @computer_sunken_ships = 0
  end

  def main_menu
    sleep(1)
    puts <<-'EOF'
                         __      __       .__                               
                        /  \    /  \ ____ |  |   ____  ____   _____   ____  
                        \   \/\/   // __ \|  | _/ ___\/  _ \ /     \_/ __ \ 
                         \        /\  ___/|  |_\  \__(  <_> )  Y Y  \  ___/ 
                          \__/\  /  \___  >____/\___  >____/|__|_|  /\___  />
                               \/       \/          \/            \/     \/ 

    EOF
    `say -r 150 "Welcome"`
    puts <<-'EOF'
                                             __          
                                           _/  |_  ____  
                                           \   __\/  _ \ 
                                            |  | (  <_> )
                                            |__|  \____/ 
                                           
                                            
    EOF
    `say -r 150 "to"`
    puts <<-'EOF'
    __________    ___________________________.____     ___________ _________ ___ ___ ._____________ 
    \______   \  /  _  \__    ___/\__    ___/|    |    \_   _____//   _____//   |   \|   \______   \
     |    |  _/ /  /_\  \|    |     |    |   |    |     |    __)_ \_____  \/    ~    \   ||     ___/
     |    |   \/    |    \    |     |    |   |    |___  |        \/        \    Y    /   ||    |    
     |______  /\____|__  /____|     |____|   |_______ \/_______  /_______  /\___|_  /|___||____|    
            \/         \/                            \/        \/        \/       \/               

    EOF
    `say -r 150 "Battleship!"`
    puts <<-'EOF'
                                                  __/___            
                                            _____/______|           
                                    _______/_____\_______\_____     
                                    \              < < <       |    
                                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    EOF
    sleep(2)
    puts <<-'EOF'
                                                |    |    |                 
                                               )_)  )_)  )_)              
                                              )___))___))___)\            
                                             )____)____)_____)\\
                                           _____|____|____|____\\\__
                                  ---------\                   /---------
                                      ^^^^^ ^^^^^^^^^^^^^^^^^^^^^
                                        ^^^^      ^^^^     ^^^    ^^
                                              ^^^^      ^^^

    EOF
    sleep(2)
    50.times{puts}
    sleep(3)
    puts 'ARRRRR MATEY!' 
    sleep(2)
    puts
    puts 'Are you ready to play BATTLESHIP?'
    sleep(2)
    puts
    puts 'Enter "p" + "enter" to play...'
    sleep(1)
    puts '...and probably lose'
    sleep(1)
    puts
    puts 'OR'
    sleep(1)
    puts
    puts 'Just type "q" + "enter" if you are scared' 
    sleep(1)
    puts 'and want to quit...'
    input = gets.chomp.downcase
    if input == 'p'
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
      `say -r 150 "Let's play"`
      sleep(1)
      puts
      play_game
    elsif input == 'q'
      puts 'Ah! I knew you were scared! Muhaha!'
      `say -r 150 "Goodbye"`
      #edge case for any other letter entered
      exit
    else
      puts 'Please type "p" or "q" and "enter" to continue'
    end
  end

  def play_game
    computer_placement(@computer.cruiser)
    computer_placement(@computer.submarine)
    lists_rules
    puts 'First, you must place your Cruiser on the board. ' +
    'Type in 3 valid coordinates in either a horizontal or vertical row'
    puts 'Example: A1 A2 A3'
    `say -r 150 "Time to place your cruiser"`
    player_placement(@player.cruiser)
    puts
    puts 'Place your Submarine! Type in 2 valid coordinates in a horizonal or vertical row.'
    puts 'Example: B1 B2:'
    `say -r 150 "Now place your Submarine"`
    puts
    puts @player.board.render(true)
    2.times{puts}
    player_placement(@player.submarine)
    puts 
    puts '        Time to start the battle!'
    `say -r 150 "Time to start the battle"`


    puts
    play_turn
  end
  
  def lists_rules
    puts "I have laid out my two ships on my grid.\n" +
    "You now need decide on where to put your two ships on your grid.\n" +
    "The Cruiser is three units long and the Submarine is two units long.\n"
    puts 
    puts
    puts "Rules for Battleship placements:\n" + 
    " - The number of coordinates entered must equal the ship unit length described above\n" +
    " - All coordinates must be placed horizontally or vertically (no diagonals)\n" +
    " - All coordinates must be entered in numerical and alphabetical order\n" +
    " - No gaps are allowed when picking coordinates\n" +
    " - Ship coordinates cannot overlap with each other\n" +
    " - Examples of invalid coordinates:\n" +
    "   - A2 B3 C4 (diagonal placement is not allowed)\n" +
    "   - A3 A2 A1 (must be in numerical order)\n" +
    " - Exampes of valid coordinates:\n" +
    "   - A4 B4 C5\n" +
    "   - D2 D3"
    `say -r 150 "Here are the rules and your current grid"`
    2.times{puts}
    puts 'Here is how your board looks currently!'
    puts @player.board.render(true)
    2.times{puts}
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
      puts 'Those are invalid coordinates. Please try again:'
      input = gets.chomp.upcase
      coordinate_array = input.split(" ")
    end
    puts
    puts "Huzzah! You've placed your #{ship.name}!"
    @player.board.place(ship, coordinate_array)
  end

  def play_turn
    until there_is_a_winner do
      puts '===============COMPUTER BOARD==============='
      puts @computer.board.render
      puts
      puts '=================YOUR BOARD================='
      puts @player.board.render(true)
      puts
      puts '(S = Ship, H = Hit, M = Miss, X = Sunk Ship)'
      puts
      puts 'It is your turn. Pick one coordinate on the computers board to fire upon:'
      player_fire_upon
      computer_fire_upon
    end
  end
  
  def player_fire_upon
    input = gets.chomp.upcase
    until @computer.board.valid_coordinate?(input) && !@computer.board.cells[input].fired_upon? do
      puts 'You have either already chosen this coordinate or it is not a valid placement. Please try again:'
      input = gets.chomp.upcase
    end
    @computer.board.cells[input].fire_upon
    player_shot(input)
  end

  def player_shot(input)
    3.times{puts}
    if @computer.board.cells[input].render == 'M'
      puts "Your shot on #{input} was a miss!"
      `say -r 150 "Your shot was a miss"`
    elsif  @computer.board.cells[input].render == 'H'
      puts "Your shot on #{input} hit a ship!"
      `say -r 150 "You hit a ship"`
    elsif @computer.board.cells[input].render == 'X'
      puts "Your shot on #{input} sunk a ship!"
      `say -r 150 "You sunk a ship"`
      @computer_sunken_ships += 1
      if there_is_a_winner == true
        end_game
      end
    end
    puts
  end

  def computer_fire_upon
    puts 'Now the computer will choose a coordinate to fire upon!'
    puts
    coordinate_array = []
    until @player.board.valid_coordinate?(coordinate_array) && !@player.board.cells[coordinate_array].fired_upon? do
      coordinate_array = @computer.board.cells.keys.sample
    end
    @player.board.cells[coordinate_array].fire_upon
    puts "Computer fires upon #{coordinate_array}!"
    puts
    computer_shot(coordinate_array)
  end

  def computer_shot(coordinate_array)
    if @player.board.cells[coordinate_array].render == 'M'
      puts "The computer's shot on #{coordinate_array} was a miss!"
      `say -r 150 "The computers shot was a miss"`
    elsif  @player.board.cells[coordinate_array].render == 'H'
      puts "The computer's shot on #{coordinate_array} hit a ship!"
      `say -r 150 "The computer hit a ship"`
    elsif @player.board.cells[coordinate_array].render == 'X'
      puts "The computer's shot on #{coordinate_array} sunk a ship!"
      `say -r 150 "The computer sunk a ship"`
      @player_sunken_ships += 1
      if there_is_a_winner == true
        sleep(1)
        end_game
      end
    end
    2.times{puts}
  end

  def there_is_a_winner
    sleep(3)
    puts
    if @computer_sunken_ships == 2
      puts 'You have won the game!'
      `say -r 150 "Congrats! You have won the game!"`
      end_game
    elsif @player_sunken_ships == 2
      puts 'You lost!'
      `say -r 150 "I told you you'd probably lose! haha"`
      end_game
    else
      false
    end
    puts
  end

  def end_game
    puts
    puts 'This battle has ended!'
    `say -r 150 "The battle has ended"`
    sleep(2)
    puts <<-'EOF'
                                         ______
                                      .-"      '-.
                                     /            \
                         _          |              |          _
                        ( \         |,  .-.  .-.  ,|         / )
                         > "=._     | )(__/  \__)( |     _.=" <
                        (_/"=._"=._ |/     /\     \| _.="_.="\_)
                               "=._ (_     ^^     _)"_.="
                                   "=\__|IIIIII|__/="
                                  _.="| \IIIIII/ |"=._
                        _     _.="_.="\          /"=._"=._     _
                       ( \_.="_.="     `--------`     "=._"=._/ ))
                        > _.="                            "=._ <
                      (_/                                    \_)



    EOF
    sleep(2)
    `say -r 150 "New game in 3...2...1..."`
    main_menu
  end
end