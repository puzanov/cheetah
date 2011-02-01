require 'socket'

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
  puts Time.new.inspect
  socket.puts "HTTP/1.1 200 OK"
  socket.puts "Content-type: application/octet-stream"
  socket.puts ""
  
  File::open("/tmp/hello", "rb") do |f|
    f.each_chunk() {|chunk| socket.puts chunk }
  end

  socket.close
  puts Time.new.inspect
end


