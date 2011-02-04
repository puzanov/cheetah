require 'test/unit'
require 'lib/namba_login'

class NambaLoginTest < Test::Unit::TestCase
  def test_get_login
    session_id = "rc1kj3upp340omaj3qbb3c68i1"
    login = NambaLoginKG.get_login session_id
    puts login
  end
end

