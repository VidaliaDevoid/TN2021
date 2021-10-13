class CargoCarriage < Carriage
  attr_reader :number, :total_place
  attr_accessor :used_place

  UNITS = "m3"
  def initialize(volume)
    @type = 'cargo'
    super(volume)
  end

  def place_volume(volume)
    if free_place == 0
      raise "No free volume in carriage."
    elsif volume > free_place
      raise "Not enought volume for this item."
    else
      @used_place += volume
    end
    puts "Free volume : #{free_place}, placed volume : #{used_place}"
  end
end
