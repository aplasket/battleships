class Ship
  attr_reader :name,
              :length,
              :sunk,
              :health

  def initialize(name, length)
    @name = name
    @length = length
    @sunk = false
    @health = length
  end

  def sunk?
    @sunk
  end

  def hit
   @health -= 1
  end
end