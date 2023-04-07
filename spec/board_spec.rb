require 'spec_helper'

RSpec.describe do
  before(:each) do
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  describe '#initialize' do
    it 'exists' do
      expect(@board).to be_a(Board)
    end
  end

  describe '#cells' do
    it 'has 16 cells' do
      expect(@board.cells).to be_a(Hash)
      expect(@board.cells.size).to eq(16)
    end
  end

  describe '#validating coordinates' do
    it 'will validate coordinates that are on the board' do
      expect(@board.valid_coordinate?("A1")).to be(true)
      expect(@board.valid_coordinate?("D4")).to be(true)
      expect(@board.valid_coordinate?("A5")).to be(false)
      expect(@board.valid_coordinate?("E1")).to be(false)
      expect(@board.valid_coordinate?("A22")).to be(false)
    end
  end

  describe '#validating placement' do
    it 'will check that coordinates match length of ship' do
      expect(@board.valid_placement?(@cruiser, ["A1", "A2"])).to be(false)
      expect(@board.valid_placement?(@submarine, ["A2", "A3", "A4"])).to be(false)
    end
  end
end