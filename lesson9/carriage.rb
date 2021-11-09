# frozen_string_literal: true

require_relative 'producer'
require_relative 'validation'

class Carriage
  include Producer
  include Validation

  attr_reader :type, :total_place
  attr_accessor :used_place

  TYPES = %w[cargo passenger].freeze

  validate :total_place, :presence

  def initialize(total_place)
    @number = rand(100..999)
    @total_place = total_place
    @used_place = 0
    validate!
  end

  def free_place
    total_place - used_place
  end

  protected

  # def valid?
  #   validate!
  #   true
  # rescue StandardError
  #   false
  # end

  # def validate!
  #   raise ArgumentError, 'Use cargo or passenger type.' unless TYPES.include?(type)
  # end
end
