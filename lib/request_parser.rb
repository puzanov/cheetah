class RequestParser
  def get_uri request
    regexp = /get \/(.*?) http/is
    matches = regexp.match request
    if matches
      matches[1]
    end
  end
end
