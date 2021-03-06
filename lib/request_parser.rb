class RequestParser
  def get_uri request_headers
    regexp = /get \/(.*?) http/is
    matches = regexp.match request_headers
    if matches
      matches[1]
    end
  end

  def get_ip request_headers
    regexp = /X-Real-IP: (.*?)\n/is
    matches = regexp.match request_headers
    if matches
      matches[1]
    end
  end

  def get_session_id request_headers
    regexp = /SESSION-ID=(.*?)(;|\n|\ )/is
    matches = regexp.match request_headers
    if matches
      matches[1]
    end
  end
end
