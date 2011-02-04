require 'test/unit'
require 'lib/namba_login'

class NambaLoginTest < Test::Unit::TestCase
  def test_get_login
    session_id = "rc1kj3upp340omaj3qbb3c68i1"
    login = NambaLogin.get NambaLogin.get_dev_namba_url session_id
    puts login
  end
end

