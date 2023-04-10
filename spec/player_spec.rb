require 'spec_helper'

RSpec.describe Player do
  before(:each) do
    @player = Player.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  describe '#initialize' do
    it 'exists' do
      expect(@player).to be_an_instance_of(Player)
    end

    it 'has attributes' do
      expect(@player.board).to be_a(Board)
    end
  end
end