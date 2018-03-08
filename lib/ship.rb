# Generic class for any ship; stores size, name and gamepiece token as
# attributes with minimal validation on ship size and naming
class Ship
  attr_reader :name
  attr_reader :length
  attr_reader :token
  attr_accessor :coordinates

  def initialize(name: '', length: 0)
    raise 'Ship lengths must be an integer' unless length.class == Integer
    raise 'Ships cannot be invisible' if length.zero?
    raise 'Ship names must be alphanumeric and start with a letter' unless /^[A-Za-z][\w\s]+/ =~ name

    @name = name
    @length = length
    @token = name[0].upcase
  end
end
