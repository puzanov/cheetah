require 'rubygems'
require 'sinatra'
require 'yaml'
require 'lib/provider_discover'


get '/' do
  @config = YAML.load_file("config.yml")
  @token = generate_token
  discover = ProviderDiscover.new
  discover.update_range_database
  @provider = discover
  erb :index 
end

get '/:file' do |file|
  puts file
end

def generate_token
  (0...10).map{ ('a'..'z').to_a[rand(26)] }.join
end
