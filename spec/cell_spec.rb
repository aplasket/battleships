require 'spec_helper'

RSpec.describe Cell do
  before(:each) do
    @cell = Cell.new("B4")
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
  end
end