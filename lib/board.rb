# Main class for Battleship game board. Init takes a board size and an array of
# ships as arguments with validation on board size (can't be smaller than ships)
class Board

  def initialize(size: 0, ships: [])
    raise 'No ships were provided' if ships.empty?
    raise 'Board size must be an integer' unless size.class == Integer
    raise 'Board cannot be smaller than largest ship' if ships.any? { |ship| ship.length > size }
    raise 'Board is too small for the provided ships' if ships.map(&:length).inject(0, &:+) > size**2

    @size = size
    @board = Array.new(size) { Array.new(size) }
    @ships = ships

    populate
  end

  def populate
    # set up a random number generator for choosing coordinates
    r = Random.new

    # iterate through each ship, place it on the board
    @ships.each do |ship|

      # start a loop to search for coordinates that will work for this ship;
      # we'll break out of it manually when we've found good coordinates
      loop do
        coordinates = []

        # choose a random set of coordinates
        y = r.rand(@size)
        x = r.rand(@size)

        # skip these coordinates now if they're already in-use
        next unless @board[y][x].nil?

        # choose the ship's orientation
        vertical = [true, false].sample

        # skip these coordinates if the length of the ship will be out of bounds
        next if (vertical ? y : x) + ship.length > @size

        # try to place the ship in a positive direction
        # check each tile the ship would occupy to see if it is already taken
        ship.length.times do |count|
          if vertical
            coordinates << [y + count, x] if @board[y + count][x].nil?
          else
            coordinates << [y, x + count] if @board[y][x + count].nil?
          end
        end

        # save the coordinates if we have enough of them; break
        if coordinates.length == ship.length
          ship.coordinates = coordinates
          break
        end

        # at this point, let's try placing the ship in the opposite direction
        # reset the saved coordinates
        coordinates = []

        # skip these coordinates if the length of the ship will be out of bounds
        next if ((vertical ? y : x) - (ship.length - 1)).negative?

        # try to place the ship in a negative direction
        # check each tile the ship would occupy to see if it is already taken
        ship.length.times do |count|
          if vertical
            coordinates << [y - count, x] if @board[y - count][x].nil?
          else
            coordinates << [y, x - count] if @board[y][x - count].nil?
          end
        end

        # save the coordinates if we have enough of them; break
        if coordinates.length == ship.length
          ship.coordinates = coordinates
          break
        end

      end

      # place the ship's tokens on the board
      ship.coordinates.each do |y, x|
        @board[y][x] = ship.token
      end

    end
  end

  # print the board to STDOUT
  # replace empty spots with '.'
  def render
    print "\n"
    @board.each do |row|
      row.each do |col|
        print "#{col.nil? ? '.' : col} "
      end
      print "\n"
    end
    print "\n"
  end
end
