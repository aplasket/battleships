class Cell
  attr_reader :coordinate,
              :ship,
              :render

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
    # @render = "."
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

  # def render
  #   if fired_upon?
  #     if
  #       "M"
  #     elsif
  #       "X"
  #     elsif
  #       "H"
  #     elsif
  #       "S"
  #     else
  #       "."
  #   end
  # end
end
