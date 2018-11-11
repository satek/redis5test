class ConsumerGroup
  def initialize(client:)
    @client = client
  end

  def stream_name
    @stream_name ||= ENV.fetch('STREAM_NAME')
  end

  def consumer_group
    @consumer_group ||= ENV.fetch('CONSUMER_GROUP')
  end

  def consumer_name
    @consumer_name ||= ENV.fetch('CONSUMER_NAME')
  end

  def create
    @client.xgroup 'create', stream_name, consumer_group, 0
  rescue Redis::CommandError => err
    puts "Group not created #{err}"
  end

  def read
    results = @client.xreadgroup 'group', consumer_group, consumer_name,
                                 'count', 2,
                                 'streams', stream_name, '>'
    return [] unless results&.any?
    _stream_name, entries = results.first
    entries
  end

  def ack(id)
    @client.xack stream_name, consumer_group, id
  end
end
