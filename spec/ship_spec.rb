require_relative '../lib/ship'
require_relative '../lib/board'

RSpec.describe Ship do

  before(:each) do
    @opts = {
      name:   'destroyer',
      length: 5
    }
  end

  context 'initialization' do

    it 'successfully initializes a new ship given valid parameters' do
      Ship.new(@opts)
    end

    it 'stores the given name of the ship as an unmodifiable attribute' do
      testship = Ship.new(@opts)
      expect(testship.name).to eq('destroyer')
      expect { testship.name = 'deathstar' }.to raise_error(NoMethodError)
    end

    it 'stores the given length of the ship as an unmodifiable attribute' do
      testship = Ship.new(@opts)
      expect(testship.length).to eq(5)
      expect { testship.length = 6 }.to raise_error(NoMethodError)
    end

    it 'capitalizes the first letter of the name and saves it as an attribute' do
      testship = Ship.new(@opts)
      expect(testship.token).to eq('D')
    end

    it 'rejects invalid ship names' do
      [
        '!3$+º%£¡',
        ' boaty mcboatface',
        '23412352'
      ].each do |name|
        @opts[:name] = name
        expect { Ship.new(@opts) }.to raise_error(RuntimeError)
      end
    end

    it 'rejects invalid ship sizes' do
      [
        0,
        'ten',
        :what
      ].each do |len|
        @opts[:length] = len
        expect { Ship.new(@opts) }.to raise_error(RuntimeError)
      end
    end

  end

  context 'gameplay' do

    it 'stores saved coordinates generated by the board' do
      ship = Ship.new(@opts)
      Board.new(size: 10, ships: [ship])
      expect(ship.coordinates.length).to eq(5)
    end

  end

end
