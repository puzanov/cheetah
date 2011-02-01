require 'rubygems'
require 'json'
require 'net/http'
require 'uri'

class Publisher
  def publish speed
    endpoint = URI.parse('http://localhost:9292/faye')
    message = {'channel' => '/foo', 'data' => {'speed'=>speed}}
    Net::HTTP.post_form(endpoint, :message => JSON.unparse(message))
  end
end
