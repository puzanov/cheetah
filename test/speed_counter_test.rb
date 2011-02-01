require 'test/unit'
require '../lib/speed_counter'

class SpeedCounterTest < Test::Unit::TestCase
  def test_calculate_speed
    filesize_in_bytes = 
    time_in_seconds = 30
    @speed_counter = SpeedCounter.new  
    @speed_counter.calculate_speed filesize_in_bytes time_in_seconds
  end
end
