require 'spec_helper'

RSpec.describe Cell do
  before(:each) do
    @cell = Cell.new("B4")
    @cruiser = Ship.new("Cruiser", 3)
  end

  describe '#initialize' do
    it 'exists' do
      expect(@cell).to be_a(Cell)
    end

    it 'has attributes' do
      expect(@cell.coordinate).to eq("B4")
    end
  end

  describe '#ship' do
    it 'starts with ship being nil' do
      expect(@cell.ship).to be(nil)
    end
  end

  describe '#empty' do
    it 'has a default of empty' do
      expect(@cell.empty?).to be(true)
    end

    it 'returns true if a ship is placed' do
      @cell.place_ship(@cruiser)

      expect(@cell.empty?).to be(false)
    end
  end

  describe '#place ship' do
    it 'can add a ship to a cell' do
      @cell.place_ship(@cruiser)

      expect(@cell.ship).to eq(@cruiser)
      expect(@cell.ship).to be_a(Ship)
    end
  end

  describe '#damaged' do
    it 'ship will be damaged when fired upon' do
      @cell.place_ship(@cruiser)

      expect(@cell.fired_upon?).to be(false)

      @cell.fire_upon

      expect(@cell.ship.health).to eq(2)
      expect(@cell.fired_upon?).to be(true)
    end
  end
end