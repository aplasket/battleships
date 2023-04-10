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
    return false unless ship.length == coordinates.count
    return false unless consecutive_check(ship, coordinates)
    return false unless not_overlapping(coordinates)
    true
  end
  
  def consecutive_check(ship, coordinates)
    letters = []
    numbers = []
    coordinates.each {|coordinate| letters << coordinate.split("").first.ord}
    coordinates.each {|coordinate| numbers << coordinate.split("").last.to_i}
    if ship.length == 3
      return false unless letters.each_cons(3).any? {|a,b,c| a - b == 0 && b - c == 0} || letters.each_cons(3).any? {|a,b,c| b == a + 1 && c == b + 1}
      return false unless numbers.each_cons(3).any? {|a,b,c| a - b == 0 && b - c == 0} || numbers.each_cons(3).any? {|a,b,c| b == a + 1 && c == b + 1}
      return false unless same_coordinates_check(coordinates)
      return true unless numbers.each_cons(3).any? {|a,b,c| b == a + 1 && c == b + 1} && letters.each_cons(3).any? {|a,b,c| b == a + 1 && c == b + 1}
    elsif ship.length == 2
      return false unless letters.each_cons(2).any? {|a,b| a - b == 0} || letters.each_cons(2).any? {|a,b| b == a + 1}
      return false unless numbers.each_cons(2).any? {|a,b| a - b == 0} || numbers.each_cons(2).any? {|a,b| b == a + 1}
      return false unless same_coordinates_check(coordinates)
      return true unless numbers.each_cons(2).any? {|a,b| b == a + 1} && letters.each_cons(2).any? {|a,b| b == a + 1}
    else
      false
    end
  end
    
  def same_coordinates_check(coordinates)
    coordinates.uniq.length == coordinates.length
  end

  def not_overlapping(coordinates)
    coordinates.all? {|coordinate| @cells[coordinate].empty?}
  end

  def place(ship, coordinates)
    coordinates.each do |coordinate|
      if @cells[coordinate].empty?
        @cells[coordinate].place_ship(ship)
      end
    end
  end

  def render (argument = false)
    if argument == true 
      "  1 2 3 4 \n" +
      "A #{@cells["A1"].render(true)} #{@cells["A2"].render(true)} #{@cells["A3"].render(true)} #{@cells["A4"].render(true)} \n" +
      "B #{@cells["B1"].render(true)} #{@cells["B2"].render(true)} #{@cells["B3"].render(true)} #{@cells["B4"].render(true)} \n" +
      "C #{@cells["C1"].render(true)} #{@cells["C2"].render(true)} #{@cells["C3"].render(true)} #{@cells["C4"].render(true)} \n" +
      "D #{@cells["D1"].render(true)} #{@cells["D2"].render(true)} #{@cells["D3"].render(true)} #{@cells["D4"].render(true)} \n"
    else
      "  1 2 3 4 \n" +
      "A #{@cells["A1"].render} #{@cells["A2"].render} #{@cells["A3"].render} #{@cells["A4"].render} \n" +
      "B #{@cells["B1"].render} #{@cells["B2"].render} #{@cells["B3"].render} #{@cells["B4"].render} \n" +
      "C #{@cells["C1"].render} #{@cells["C2"].render} #{@cells["C3"].render} #{@cells["C4"].render} \n" +
      "D #{@cells["D1"].render} #{@cells["D2"].render} #{@cells["D3"].render} #{@cells["D4"].render} \n"
      
    end
  end       

end

#edge case - can't add/place a ship that is > 3
#possible edge case - do we need to make the place method be as such that 
##   it can't even place a ship if it's overlapping?
## right now it's only returning false when we call @board.valid_placement?(@submarine, ["A1", "B1"])
## but when we call @board.place(@submarine, ["A1", "B1"]) for spec tst rb:78 it returns an array of coordinates
# do we want to consider changing to all double quotes or single quotes? We seem to be going back and forth (probably because we are copying from the Iteration)