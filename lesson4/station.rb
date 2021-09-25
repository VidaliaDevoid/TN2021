class Station
  attr_accessor :trains
  attr_reader :name

  def initialize(name)
    @name = name
    @trains = []
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
        puts "#{index + 1}) #{train.number} - #{train.train_type} train"
      end
    end
  end
end
