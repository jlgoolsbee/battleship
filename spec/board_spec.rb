require_relative '../lib/ship'
require_relative '../lib/board'

RSpec.describe Board do

  before(:each) do
    @opts = {
      size:  5,
      ships: [
        Ship.new(name: 'tug', length: 2),
        Ship.new(name: 'destroyer', length: 2),
        Ship.new(name: 'submarine', length: 3),
        Ship.new(name: 'battleship', length: 2),
        Ship.new(name: 'cruiser', length: 3)
      ]
    }
  end

  context 'initialization' do

    it 'successfully initializes a new board given valid parameters' do
      Board.new(@opts)
    end

    it 'rejects an invalid number of ships (0)' do
      @opts[:ships] = []
      expect { Board.new(@opts) }.to raise_error(RuntimeError)
    end

    it 'rejects board sizes too small to fit all provided ships' do
      @opts[:ships].concat [
        Ship.new(name: 'too', length: 5),
        Ship.new(name: 'many', length: 2),
        Ship.new(name: 'ships', length: 5),
        Ship.new(name: 'to', length: 3),
        Ship.new(name: 'fit', length: 4)
      ]
      expect { Board.new(@opts) }.to raise_error(RuntimeError)
    end

    it 'rejects board sizes smaller than the largest ship' do
      @opts[:ships] << Ship.new(name: 'too big', length: 10)
      expect { Board.new(@opts) }.to raise_error(RuntimeError)
    end

  end

  context 'gameplay' do

    before(:each) do
      @board = Board.new(@opts)
    end

    it 'renders a populated game board' do
      expect { @board.render }.to output(/^\s([TDSBC\. ]+\s)+\s$/).to_stdout
    end

    it 'assigns coordinates to all ships' do
      expect(@opts[:ships].all? { |s| s.coordinates.any? }).to eq(true)
    end

    it 'does not place ships outside the game board' do
      all_coordinates = []
      @opts[:ships].each { |s| s.coordinates.each { |c| all_coordinates << c } }
      expect(all_coordinates.flatten.all? { |n| n >= 0 && n < @opts[:size] }).to eq(true)
    end

    it 'does not place ships such that they cross/intersect' do
      all_coordinates = []
      @opts[:ships].each { |s| s.coordinates.each { |c| all_coordinates << c } }
      expect(all_coordinates).to eq(all_coordinates.uniq)
    end
  end

end
