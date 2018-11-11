$:.unshift File.dirname(__FILE__)

require 'redis'
require 'stream'
require 'consumer_group'
require 'pry'

$client = Redis.new(host: 'redis', driver: :hiredis)

task :producer do
  stream = Stream.new(client: $client)

  nr = 0
  loop do
    nr += 1
    stream.add "key#{nr}", nr.to_s
    puts "Posted #{nr}"
    sleep 0.2
  end
end

task :consumer do
  group = ConsumerGroup.new(client: $client)
  puts "starting #{group.consumer_name} in #{group.consumer_group}"
  group.create

  loop do
    group.read.each do |id, (key, val)|
      puts id
      group.ack id
      puts "ACK key: #{key}, val: #{val}"
    end
    sleep 0.4
  end
end

task :console do
  Pry.start
end
