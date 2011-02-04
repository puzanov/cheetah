class RequestParser
  def get_uri request_headers
    regexp = /get \/(.*?) http/is
    matches = regexp.match request_headers
    if matches
      matches[1]
    end
  end

  def get_ip request_headers
    regexp = / \/(.*?) http/is
    matches = regexp.match request_headers
    if matches
      matches[1]
    end
  end
end
