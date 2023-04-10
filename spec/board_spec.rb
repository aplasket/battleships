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
    
    it 'check that coordinates are consecutive' do
      expect(@board.valid_placement?(@cruiser, ["A1", "A2", "A4"])).to be(false)
      expect(@board.valid_placement?(@submarine, ["A1", "C1"])).to be(false)
      expect(@board.valid_placement?(@cruiser, ["A3", "A2", "A1"])).to be(false)
      expect(@board.valid_placement?(@submarine, ["C1", "B1"])).to be(false)
      expect(@board.consecutive_check(@cruiser, ["A1", "A2", "A3"])).to be(true)
      expect(@board.consecutive_check(@cruiser, ["A1", "A2", "A4"])).to be(false)

    end

    it 'checks that same coordinates cannot be used' do
      expect(@board.valid_placement?(@submarine, ["A1", "A1"])).to be(false)
      expect(@board.valid_placement?(@cruiser, ["A1", "B1", "A1"])).to be(false)
    end

    it 'checks that coordinates are not diagonal' do
      expect(@board.valid_placement?(@cruiser, ["A1", "B2", "C3"])).to be(false)
      expect(@board.valid_placement?(@submarine, ["C2", "D3"])).to be(false)
    end

    it 'checks that the ship placement is valid' do
      expect(@board.valid_placement?(@submarine, ["A1", "A2"])).to be(true)
      expect(@board.valid_placement?(@cruiser, ["B1", "C1", "D1"])).to be(true)
    end
  end

  describe '#place' do
    it 'can place a ship on the board with valid coordinates' do
      @board.place(@cruiser, ["A1", "A2", "A3"])
      cell_1 = @board.cells["A1"]
      cell_2 = @board.cells["A2"]
      cell_3 = @board.cells["A3"]  

      expect(cell_1.ship).to eq(@cruiser)
      expect(cell_2.ship).to eq(@cruiser)
      expect(cell_3.ship).to eq(@cruiser)
      expect(cell_3.ship == cell_2.ship).to be(true)
    end

    it 'ensures ship placements do not overlap' do
      @board.place(@cruiser, ["A1", "A2", "A3"])
      expect(@board.valid_placement?(@submarine, ["A1", "B1"])).to be(false)
    end
  end

  describe '#render board' do
    it 'returns a string representation of the board with hidden ships' do
      @board.place(@cruiser, ["A1", "A2", "A3"])

      expect(@board.render).to eq("  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n")
    end
    
    it 'returns a string representation of the board with visible ships' do
      @board.place(@cruiser, ["A1", "A2", "A3"])
      @board.place(@submarine, ["D3", "D4"])
      expect(@board.render(true)).to eq("  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . S S \n")
    end
  end
end