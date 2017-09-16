#require "./redis2ws/*"
require "kemal"
require "redis"

module Redis2ws
  SOCKETS = [] of HTTP::WebSocket # which type are the objects in this empty list :O
  
  #run redis subscriber in its own fiber
  spawn do
    redis = Redis.new
    redis.subscribe("mychannel") do |on|
      on.message do |channel, message|
        puts message
        SOCKETS.each { |socket| socket.send message }
      end
    end
  end
  
  # The Kemal app, pretty straightforward.
  
  # While static files get served from the /public directory, this doesn't work for calls to `/`, so
  # we have to hardcode that one.
  get "/" do |ctx|
    send_file ctx, "public/index.html"
  end
  
  ws "/eventstream/" do |socket|
    # Add the client to SOCKETS list
    SOCKETS << socket

    # Broadcast each message to all clients
    socket.on_message do |message|
      # we don't really care about what clients send to us, but leaving this in as an
      # example for how you could do stuff when people send you messages
    end

    # Remove clients from the list when it’s closed
    socket.on_close do
      SOCKETS.delete socket
    end
  end
  
  Kemal.run
end


