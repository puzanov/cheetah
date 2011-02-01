require 'socket'
FILENAME_TO_DOWNLOAD = '/tmp/hello'


class File
  def each_chunk(chunk_size=1024)
    yield read(chunk_size) until eof?
  end
end

server = TCPServer.new('0.0.0.0', 4567)
loop do
  socket = server.accept
  while socket.gets.chop.length > 0
  end
  
  @start_date = Time.new.to_i
  
  socket.puts "HTTP/1.1 200 OK"
  socket.puts "Content-type: application/octet-stream"
  socket.puts ""
  
  File::open(FILENAME_TO_DOWNLOAD, "rb") do |f|
    f.each_chunk() {|chunk| socket.puts chunk }
  end

  socket.close
  
  @end_date = Time.new.to_i

  seconds_spent = @end_date - @start_date

  puts File.new(FILENAME_TO_DOWNLOAD).size / seconds_spent * 1024
end


