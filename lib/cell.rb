class Cell
  attr_reader :coordinate,
              :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
  end

  def empty?
    @ship == nil
  end

  def place_ship(new_ship)
    if empty?
      @ship = new_ship
    else
      "This cell already contains a ship, please choose a new coordinate"
    end
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    if @ship
      @ship.hit
      @fired_upon = true
    end
  end

  def render (argument = false)
    if argument == true && !empty? && !fired_upon?
      "S"
    elsif fired_upon? && empty?
      "M"
    elsif fired_upon? && !empty?
      if !ship.sunk?
        "H"
      else
        "X"
      end
    else !fired_upon?
      "."
    end
  end
end
