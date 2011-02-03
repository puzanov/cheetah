require 'socket'
require 'yaml'
require 'lib/speed_counter'
require 'lib/publisher'
require 'lib/request_parser'
FILENAME_TO_DOWNLOAD = '/tmp/hello'
FILESIZE = File.size FILENAME_TO_DOWNLOAD
CONFIG = YAML.load_file("config.yml")

class File
  def each_chunk(chunk_size=1024)
    yield read(chunk_size) until eof?
  end
end

server = TCPServer.new('0.0.0.0', 5678)
loop do
  socket = server.accept
  puts socket.inspect
  Thread.new do
    begin
      request = socket.gets.chop
      puts request
      uri = RequestParser.new.get_uri request
      while socket.gets.chop.length > 0 do
      end
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
      if speed > 1024
        speed = speed / 1024
        message_to_publish = speed.to_s + " мегабайт в секунду"
      else
        message_to_publish = speed.to_s + " кб в секунду"
      end
    ensure
      publisher = Publisher.new
      publisher.faye_url = CONFIG['faye_local_url']
      publisher.publish message_to_publish, uri 
      socket.close
    end
  end
end


