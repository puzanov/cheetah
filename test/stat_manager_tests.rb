require 'test/unit'
require 'rubygems'
require 'active_record'
require 'sqlite3'

class StatManagerTest < Test::Unit::TestCase
  def test_init
    StatManager.establesh_connection
    stat = Stat.new
    stat.name = "anonim"
    stat.save
  end
end

class StatManager
  def StatManager.establesh_connection
    ActiveRecord::Base.establish_connection(
      :adapter  => 'sqlite3',
      :database => 'data/stat.db')
  end
end

class Stat < ActiveRecord::Base
end


