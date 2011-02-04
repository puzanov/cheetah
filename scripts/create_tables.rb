require 'rubygems'
require 'sqlite3'
require 'active_record'

ActiveRecord::Base.establish_connection(
  :adapter  => 'sqlite3',
  :database => 'data/stat.db')

ActiveRecord::Schema.define :version => 0 do
  create_table :stats do |t|
    t.string :name
    t.string :provider
    t.integer :speed
    t.integer :ctime
  end
end

