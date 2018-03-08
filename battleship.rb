require 'yaml'
require_relative 'lib/ship'
require_relative 'lib/board'

# load the configuration (ship details and board size)
config = YAML.load_file('config.yml')

# create new ships
ships = config[:ships].map { |params| Ship.new(params) }

# create the board
board = Board.new(size: config[:board][:size], ships: ships)

# render the board
board.render
