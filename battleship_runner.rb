require './spec/spec_helper'

player = Player.new
computer = Computer.new
game = Game.new(computer, player)

game.start

