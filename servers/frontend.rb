require 'rubygems'
require 'faye'
require 'sinatra'
require 'yaml'
require 'lib/provider_discover'
require 'lib/stat_manager'

use Faye::RackAdapter, :mount      => '/faye',
                       :timeout    => 20

get '/' do
  @config = YAML.load_file("config.yml")
  @token = generate_token
  discover = ProviderDiscover.new
  discover.update_range_database
  user_ip = request.env['HTTP_X_REAL_IP']
  user_ip = request.env['REMOTE_ADDR'] unless user_ip
  @provider = discover.guess user_ip
  @stats = Stat.find :all, :order => "ctime DESC", :conditions => ["speed > 0"]
  erb :index 
end

get '/:file' do |file|
  puts file
end

def generate_token
  (0...10).map{ ('a'..'z').to_a[rand(26)] }.join
end
