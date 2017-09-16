# redis2ws

This repo contains a (very simple) example of passing messages from Redis pubsub to websocket connections.

## Installation

You'll need the `kemal` and `redis` shards for this to work. Running `shards install` in the repo directory should "just work". 

## Usage

Make sure you have Redis installed and a Redis server running locally on the default port. Clone this repo and move into its directory, then run `crystal src/redis2ws.cr`. Navigate a browser to `localhost:3000`. Use your preferred means of publishing messages to the Redis pubsub channel `mychannel` (in redis-cli, you can use `publish mychannel mymessage`). Observe the message you published appear in the browser window.

That is all it does so far.

## Contributing

I'm not really looking for contributions at this point, this project is simply about playing around with tech I find interesting. Feel free to take inspiration from the code though, that is why it is public in the first place. :) 

## Contributors

- [[WJWH]](https://github.com/WJWH) Wander Hillen - creator, maintainer
