require 'spec_helper'

RSpec.describe Player do
  before(:each) do
    @player = Player.new
  end

  describe '#initialize' do
    it 'exists' do
      expect(@player).to be_an_instance_of(Player)
    end

    it 'has attributes' do
      expect(@player.board).to be_a(Board)
      expect(@player.cruiser).to be_a(Ship)
      expect(@player.submarine).to be_a(Ship)
    end
  end
end