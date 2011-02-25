require 'rubygems'
require 'active_record'
require 'sqlite3'

class StatManager
  def StatManager.establish_connection
    ActiveRecord::Base.establish_connection(
      :adapter  => 'sqlite3',
      :database => 'data/stat.db')
  end
end

class Stat < ActiveRecord::Base
end

StatManager.establish_connection
