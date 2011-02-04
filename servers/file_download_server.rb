require 'socket'
require 'yaml'
require 'lib/speed_counter'
require 'lib/publisher'
require 'lib/request_parser'
require 'lib/stat_manager'
require 'lib/provider_discover'
require 'lib/namba_login'

FILENAME_TO_DOWNLOAD = '/tmp/hello'
FILESIZE = File.size FILENAME_TO_DOWNLOAD
CONFIG = YAML.load_file("config.yml")

class File
  def each_chunk(chunk_size=1024)
    yield read(chunk_size) until eof?
  end
end

@discover = ProviderDiscover.new
@discover.update_range_database

server = TCPServer.new('0.0.0.0', 5678)
loop do
  socket = server.accept
  puts socket.inspect
  Thread.new do
    begin
      request_headers = ""
      begin
        request_line = socket.gets
        request_headers << request_line
      end while request_line.chop.length > 0

      uri = RequestParser.new.get_uri request_headers
      puts uri
      puts request_headers

      start_date = Time.new.to_i
      socket.puts "HTTP/1.0 200 OK"
      socket.puts "Content-type: application/octet-stream"
      socket.puts "Content-Disposition: attachment; filename=\"zero.dat\"";
      socket.puts "Content-length: " + FILESIZE.to_s
      socket.puts "Pragma: no-cache"
      socket.puts "Expires: 0"
      socket.puts ""
      File::open(FILENAME_TO_DOWNLOAD, "rb") do |f|
        f.each_chunk() {|chunk| socket.puts chunk }
      end
    rescue
      puts $!
      message_to_publish = "Закачка файла прервалась"  
    else
      end_date = Time.new.to_i
      seconds_spent = end_date - start_date
      puts "start #{start_date} end #{end_date}"
      speed = SpeedCounter.new.calculate_speed FILESIZE, seconds_spent
      speed_to_stat = speed
      if speed > 1024
        speed = speed / 1024
        message_to_publish = speed.to_s + " МБайт в секунду"
      else
        message_to_publish = speed.to_s + " КБайт в секунду"
      end
    ensure
      publisher = Publisher.new
      publisher.faye_url = CONFIG['faye_local_url']
      publisher.publish message_to_publish, uri 
      ip = RequestParser.new.get_ip request_headers
      ip = socket.addr[3] unless ip
      
      session_id = RequestParser.new.get_session_id request_headers
      namba_login = NambaLogin.get NambaLogin.get_kg_namba_url session_id
      
      stat = Stat.new
      stat.name = login
      stat.name = "anonim" unless login
      stat.speed = speed_to_stat
      stat.provider = @discover.guess ip.chomp
      stat.ctime = Time.new.to_i
      stat.save
      socket.close
    end
  end
end
