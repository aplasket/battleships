require './spec/spec_helper'

player = Player.new
computer = Computer.new
game = Game.new(computer, player)
cruiser = Ship.new("Cruiser", 3)

game.start
