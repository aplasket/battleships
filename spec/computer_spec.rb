require 'spec_helper'

RSpec.describe Computer do
  before(:each) do
    @computer = Computer.new
  end

  describe '#initialize' do
    it 'exists' do
      expect(@computer).to be_an_instance_of(Computer)
    end

    it 'has attributes' do
      expect(@computer.board).to be_a(Board)
      expect(@player.cruiser).to be_a(Ship)
      expect(@player.submarine).to be_a(Ship)
    end
  end
end