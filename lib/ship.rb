class Ship
  attr_reader   :name,
                :length,
                :health
  attr_accessor :sunk

  def initialize(name, length)
    @name = name
    @length = length
    @sunk = false
    @health = length
  end

  def sunk?
    @health == 0
  end

  def hit
    @health -= 1
  end
end