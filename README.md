# Redis 5 streams used from Ruby

## Usage

Make sure you have Docker and Docker Compose installed and run `docker-compose up` to have the whole environment built and run for you.
Docker Compose sets up necessary environment variables and runs one producer and two consumers belonging to the same consumer group.
You can tweak the variables to have them run in the different groups or indeed run multiple consumers in multiple consumer groups manually.

## Available commands

To play around you can use these commands.
Their behaviour can be modified by passing different environment variables.
These variables are all in `docker-compose.yml`.

* `docker-compose run producer` to start producing messages to the stream
* `docker-compose run consumer1` to start the first consumer
* `docker-compose run consumer2` to start the second consumer
* `docker-compose run console` to start the console to inspect the stream

When the console (Pry session) starts Redis client is initialised and stored in the `$client` global variable.


Services are in the `docker-compose.yml` only for convenience. Since they are all the same Docker image any command can be run on any of the images.
For example `docker-compose run producer console` would start the console and `docker-compose run consumer1 producer` would start a producer. Every command is actually a rake taks defined in the Rakefile.

### Example: start two consumers in another consumer group
* Make sure that redis is running `docker-compose start redis` 
* In the first console window run `docker-compose run -e "CONSUMER_GROUP=anothergroup" -e "CONSUMER_NAME=first" consumer1`
* In the second one run `docker-compose run -e "CONSUMER_GROUP=anothergroup" -e "CONSUMER_NAME=second" consumer1`

Now another group of consumers are running on the same stream. In the same way, by tweaking, environment variables a producer could be run for another stream with it's own set of consumers.

### Example: trim the stream from the console

If you have a producer running your should have a lot of items in your stream (named `mystream` by default in compose file).
First, run the console `docker-compose run console`.

To check the length of the stream run `$client.xlen 'mystream'`. Now, to trim the stream to 1000 messages run `$client.xtrim 'mystream', 'maxlen', '~', 1000 `.

## Sources and resources

* Introduction to this exciting new feature can be found [here on Redis website](https://redis.io/topics/streams-intro) with a nice explanation of the commands used here and much, much more.
* client used is actually [redis-rb gem](https://github.com/redis/redis-rb) with [hiredis-rb driver](https://github.com/redis/hiredis-rb)
* obviously [Docker and Docker Compose](https://docs.docker.com/compose)
