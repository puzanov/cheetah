require 'socket'
require 'lib/speed_counter'
require 'lib/publisher'
FILENAME_TO_DOWNLOAD = '/tmp/hello'
FILESIZE = File.size FILENAME_TO_DOWNLOAD

class File
  def each_chunk(chunk_size=1024)
    yield read(chunk_size) until eof?
  end
end

server = TCPServer.new('0.0.0.0', 5678)
loop do
  socket = server.accept
  while socket.gets.chop.length > 0
  end
 
  begin
    @start_date = Time.new.to_i
    socket.puts "HTTP/1.1 200 OK"
    socket.puts "Content-type: application/octet-stream"
    socket.puts "Content-Disposition: attachment; filename=\"zero.dat\"";
    socket.puts "Content-length: " + FILESIZE.to_s
    socket.puts ""
    File::open(FILENAME_TO_DOWNLOAD, "rb") do |f|
      f.each_chunk() {|chunk| socket.puts chunk }
    end
    socket.close
  rescue
    message_to_publish = "Закачка файла прервалась"  
  else
    @end_date = Time.new.to_i
    seconds_spent = @end_date - @start_date
    message_to_publish = SpeedCounter.new.calculate_speed FILESIZE, seconds_spent
    message_to_publish = message_to_publish.to_s + " кб в секунду"
  ensure
    Publisher.new.publish message_to_publish  
  end
end


