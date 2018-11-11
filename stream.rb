class Stream
  def initialize(client:)
    @client = client
  end

  def stream_name
    ENV.fetch('STREAM_NAME')
  end

  def add(key, val)
    # `*` tells Redis to generate an ID
    @client.xadd stream_name, '*', key, val
  end
end
