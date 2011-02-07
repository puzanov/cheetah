#!/bin/sh
killall ruby

if [ -z "$1" ]; then
  nohup ruby servers/file_download_server.rb &
  nohup ruby servers/frontend.rb &
else
  ruby servers/file_download_server.rb &
  ruby servers/frontend.rb &
fi


