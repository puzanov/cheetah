require 'faye'
faye_server = Faye::RackAdapter.new(:mount => '/faye', :timeout => 20)
run faye_server
