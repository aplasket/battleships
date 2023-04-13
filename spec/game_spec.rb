require 'spec_helper'

RSpec.describe Game do
  before(:each) do
    @game = Game.new
  end

  describe '#initialize' do
    it 'exists' do
      expect(@game).to be_a(Game)
    end

    it 'has attributes' do
      expect(@game.computer).to be_a(Computer)
      expect(@game.player).to be_a(Player)
    end

    it 'starts with 0 sunken ships' do
      expect(@game.player_sunken_ships).to eq(0)
      expect(@game.computer_sunken_ships).to eq(0)
    end
  end
end