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

  def test_get_ip
    request_headers = 
"
GET /liqjsswjbo HTTP/1.0
X-Real-IP: 77.235.20.226
Host: 91.213.233.8:5678
Connection: close
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.2.13) Gecko/20101203 Firefox/3.6.13 (.NET CLR 3.5.30729)
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
Accept-Language: ru-ru,ru;q=0.8,en-us;q=0.5,en;q=0.3
Accept-Encoding: gzip,deflate
Accept-Charset: windows-1251,utf-8;q=0.7,*;q=0.7
Cookie: __utma=81652360.1689277399.1296375462.1296787091.1296794397.27; __utmz=81652360.1296794397.27.5.utmcsr=blogs.namba.kg|utmccn=(referral)|utmcmd=referral|utmcct=/post.php; -1829530427_block=display; 282317464_block=display; 323037004_block=display; 952417824_block=display; 1843775335_block=none; __utmc=81652360; SESSION-ID=0b8c7e401d1147ab504c243be469d50e
"
    @rp = RequestParser.new
    ip = @rp.get_ip request_headers
    assert_equal "77.235.20.226", ip
  end
end
