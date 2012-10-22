require 'connection_pool'

redis_pool = ConnectionPool.new(:size => 5, :timeout => 5) { Redis.new(:host => 's.hack3r.me', :port => 6379, :password => 'c069da7f92197c827b41758a42763c93d82001ac') }

SHARE_UPDATER_QUEUE = GirlFriday::WorkQueue.new(:share_updater, :size => 7) do |msg|
	Company.update_shares
end