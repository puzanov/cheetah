require 'rubygems'
require 'sinatra'

get '/' do
  @token = generate_token
  erb :index 
end

def generate_token
  (0...10).map{ ('a'..'z').to_a[rand(26)] }.join
end
