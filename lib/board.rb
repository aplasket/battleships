class Board
  attr_reader :cells
  def initialize
    @cells = {
      "A1" => Cell.new("A1"),
      "A2" => Cell.new("A2"),
      "A3" => Cell.new("A3"),
      "A4" => Cell.new("A4"),
      "B1" => Cell.new("B1"),
      "B2" => Cell.new("B2"),
      "B3" => Cell.new("B3"),
      "B4" => Cell.new("B4"),
      "C1" => Cell.new("C1"),
      "C2" => Cell.new("C2"),
      "C3" => Cell.new("C3"),
      "C4" => Cell.new("C4"),
      "D1" => Cell.new("D1"),
      "D2" => Cell.new("D2"),
      "D3" => Cell.new("D3"),
      "D4" => Cell.new("D4")
    } 
  end

  def valid_coordinate?(coordinate)
    @cells.has_key?(coordinate)
  end

  def valid_placement?(ship, coordinates)
    ship.length == coordinates.count
    consecutive_check(ship, coordinates)
  end
  
  def consecutive_check(ship, coordinates)
    letters = []
    numbers = []
    coordinates.each {|coordinate| letters << coordinate.split("").first.ord}
    coordinates.each {|coordinate| numbers << coordinate.split("").last.to_i}
    if ship.length == 2
      # require 'pry'; binding.pry
      if letters.each_cons(2).any? {|a,b| a - b == 0} || letters.each_cons(2).any? {|a,b| b == a + 1}
        if numbers.each_cons(2).any? {|a,b| a - b == 0} || numbers.each_cons(2).any? {|a,b| b == a + 1}
          if same_coordinates_check(coordinates)
           true
          else
            false
          end
        end
      end
    end
  end
  
  def same_coordinates_check(coordinates)
    coordinates.uniq.length == coordinates.length
  end
end

#edge case - can't put the same coordinates in [A1, A1]