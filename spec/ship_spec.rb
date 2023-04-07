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
end