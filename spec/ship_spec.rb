require 'spec_helper'

RSpec.describe Ship do

  before(:each) do
    @cruiser = Ship.new("Cruiser", 3)
  end

  describe '#initialize' do
    it 'exists' do
      expect(@cruiser).to be_a(Ship)
    end

    it 'has attributes' do
      expect(@cruiser.name).to eq("Cruiser")
      expect(@cruiser.length).to eq(3)
    end
  end

  describe '#health' do
    it 'starts with full health equal to ship.length' do
      expect(@cruiser.health).to eq(3)
    end
  end

  describe '#sunk' do
    it 'starts with a default status of false' do
      expect(@cruiser.sunk?).to be(false)
    end

    it 'ship is sunk after being hit eq to ship.length' do
      @cruiser.hit
      expect(@cruiser.sunk?).to be(false)
      @cruiser.hit
      require 'pry'; binding.pry
      expect(@cruiser.sunk?).to be(false)
      @cruiser.hit
      expect(@cruiser.sunk?).to be(true)
    end
  end

  describe '#hit' do
    it 'can lose health when hit' do
      @cruiser.hit
      expect(@cruiser.health).to eq(2)

      @cruiser.hit
      expect(@cruiser.health).to eq(1)
    end
  end
end