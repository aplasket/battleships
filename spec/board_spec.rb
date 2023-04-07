require 'spec_helper'

RSpec.describe do
  before(:each) do
    @board = Board.new
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
end