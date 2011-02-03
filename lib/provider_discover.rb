class ProviderDiscover
  require 'open-uri'
  require 'ipaddr'

  attr_accessor :range_database

  def update_range_database
    @range_database = open("http://www.elcat.kg/ip/kg-nets-isp.txt").read
  end

  def guess ip
    @range_database.each do |line|
      info = line.split
      range = info[0]
      provider = info[1]
      iparrd = IPAddr.new range
      if iparrd.include? IPAddr.new(ip)
        return provider
      end
    end
    return ""
  end
end
