require 'test/unit'
require 'lib/provider_discover'

class ProviderDiscoverTest < Test::Unit::TestCase
  attr_accessor :discover
  def setup
    @discover = ProviderDiscover.new
    @discover.update_range_database
  end
  
  def test_guess_megaline
    provider = @discover.guess "77.235.20.226"
    assert_equal "MEGALINE", provider
  end
  def test_guess_elcat
    provider = @discover.guess "212.42.96.1"
    assert_equal "ELCAT", provider
  end
end

