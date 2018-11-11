# Redis 5 streams used from Ruby

## Usage

Make sure you have Docker and Docker Compose installed and run `docker-compose up` to have the whole environment built and run for you.
Docker Compose sets up necessary environment variables and runs one producer and two consumers belonging to the same consumer group.
You can tweak the variables to have them run in the different groups or indeed run multiple consumers in multiple consumer groups manually.

## Available commands

To play around and run commands manually you can use these commands.
Their behaviour can be modified by passing different environment variables.
These variables are all in `docker-compose.yml`.

* `docker-compose run producer` to start producing messages to the stream
* `docker-compose run consumer1` to start the first consumer
* `docker-compose run consumer2` to start the second consumer
* `docker-compose run console` to start the console to inspect the stream

When the console (Pry session) starts Redis client is initialised and stored in the `$client` global variable.


Those services are in the `docker-compose.yml` only for convenience. Since they are all the same Docker image any command can be run on any of the images by simply overriding the command.
For example `docker-compose run producer console` would start the console and `docker-compose run consumer1 producer` would start a producer.
