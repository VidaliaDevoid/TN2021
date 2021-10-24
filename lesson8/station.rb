# frozen_string_literal: true

require_relative 'instance_counter'

class Station
  include InstanceCounter
  attr_accessor :trains
  attr_reader :name

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    validate!
    register_instance
  end

  def get_trains_by_type(type)
    trains.select { |t| t.type == type }
  end

  def add_train(train)
    trains << train
  end

  def remove_train(train)
    trains.delete(train)
  end

  def trains_list
    return if trains.empty?

    puts "On station '#{name}':"
    trains.each.with_index do |train, index|
      puts "#{index + 1}) #{train.number} - #{train.type} train"
    end
  end

  def each_train(&block)
    trains.each(&block)
  end

  def list_trains
    each_train do |t|
      puts "##{t.number} #{t.type} -- carriage count: #{t.carriages.count}."
    end
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def validate!
    raise ArgumentError, 'Empty or nil name station.' if name.nil? || name.empty?
  end
end
