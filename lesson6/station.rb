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
    trains.select{|t| t.type == type}
  end

  def add_train(train)
    trains << train
  end

  def remove_train(train)
    trains.delete(train)
  end

  def trains_list
    unless trains.empty?
      puts "On station '#{self.name}':"
      trains.each.with_index do |train, index|
        puts "#{index + 1}) #{train.number} - #{train.type} train"
      end
    end
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  def validate!
    raise ArgumentError, 'Empty or nil name station.' if name.nil? || name.empty?
  end
end
