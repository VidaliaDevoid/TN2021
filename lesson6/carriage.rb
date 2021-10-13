require_relative 'producer'

class Carriage
  include Producer
  attr_reader :type

  TYPES = ['cargo', 'passenger'].freeze

  def initialize
    validate!
  end

  protected
  def valid?
    validate!
    true
  rescue
    false
  end

  def validate!
    raise ArgumentError, 'Use cargo or passenger type.' unless TYPES.include?(type)
  end
end
