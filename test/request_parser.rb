require 'test/unit'
require 'lib/speed_counter'
require 'lib/request_parser'

class RequestParserTest < Test::Unit::TestCase
  def test_get_uri
    request = "GET /1234 HTTP/1.0"
    @rp = RequestParser.new
    uri = @rp.get_uri request
    assert_equal "1234", uri
  end
end
