# Battleship

An implementation of the classic game "Battleship" written in Ruby. This is not a full game; at the moment, all that exists are routines to create ships and game boards, and to place the configured ships on the game board such that the ships:

* are placed randomly
* do not overlap/intersect
* do not extend/wrap past the edges of the board

Note: requires Ruby 2.4.x.

## Use

Run the game:

```
ruby battleship.rb
```

The existing code will print a populated game board to STDOUT and exit. To change the ships (their number, designations, or size) or the size of the game board, edit `config.yml`.

Example output:

```

. . . . S S S . . .
. . . . . . . . . .
. . . . . . . . . .
. . . . . . . . T .
. . . . . . . . T .
. . . . . . . . . .
. . . . B B B B . .
. D . . . . . . . .
. D . . . . . . . .
. . . . . C C C C C

```

## Tests

To run the tests, run `bundle install` followed by `bundle exec rake test`.
