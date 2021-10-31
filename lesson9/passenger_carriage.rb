# frozen_string_literal: true

class PassengerCarriage < Carriage
  attr_reader :number, :total_place
  attr_accessor :seats_count, :used_place

  UNITS = 'places'

  def initialize(seats_count)
    @type = 'passenger'
    super(seats_count)
  end

  def take_seat
    raise 'No free seats in carriage.' if free_place.zero?

    @used_place += 1

    puts "Free seats : #{free_place}, placed seats : #{used_place}"
  end
end
