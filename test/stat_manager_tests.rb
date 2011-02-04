require 'test/unit'
require 'lib/stat_manager'

class StatManagerTest < Test::Unit::TestCase
  def test_create
    stat = Stat.new
    stat.name = "anonim"
    stat.save
  end
  
  def test_list
    stats = Stat.find(:all)
    stats.each do |stat|
      puts stat.inspect
    end
  end
end
