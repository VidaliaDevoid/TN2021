require_relative 'producer'

class Carriage
  include Producer
  attr_reader :type
end
