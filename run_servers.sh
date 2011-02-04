killall ruby
killall rackup
nohup rackup servers/faye.ru -s thin -E production &
nohup ruby servers/file_download_server.rb &
nohup ruby servers/frontend.rb &
