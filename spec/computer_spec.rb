require 'spec_helper'

RSpec.describe Computer do
  before(:each) do
    @computer = Computer.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  describe '#initialize' do
    it 'exists' do
      expect(@computer).to be_an_instance_of(Computer)
    end

    it 'has attributes' do
      expect(@computer.board).to be_a(Board)
    end
  end
end