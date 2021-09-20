class PassengerTrain < Train
  attr_reader :train_type

  def initialize(number)
    super
    @train_type = 'passenger'
  end 
end
