# frozen_string_literal: true

class CargoCarriage < Carriage
  attr_reader :number, :total_place
  attr_accessor :used_place

  UNITS = 'm3'
  def initialize(volume)
    @type = 'cargo'
    super(volume)
  end

  def place_volume(volume)
    raise 'No free volume in carriage.' if free_place.zero?
    raise 'Not enought volume for this item.' if volume > free_place

    @used_place += volume

    puts "Free volume : #{free_place}, placed volume : #{used_place}"
  end
end
