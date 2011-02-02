exec "dd if=/dev/zero of=/tmp/hello bs=1M count=#{ARGV[0]}"
