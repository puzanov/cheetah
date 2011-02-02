require 'rubygems'
require 'json'
require 'net/http'
require 'uri'

class Publisher
  attr_accessor :faye_url
  def publish speed, token
    endpoint = URI.parse(@faye_url)
    message = {'channel' => "/foo/#{token}", 'data' => {'speed'=>speed}}
    Net::HTTP.post_form(endpoint, :message => JSON.unparse(message))
  end
end
