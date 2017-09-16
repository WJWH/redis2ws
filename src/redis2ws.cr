#require "./redis2ws/*"
require "kemal"
require "redis"

module Redis2ws
  SOCKETS = [] of HTTP::WebSocket
  
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
  
  # For root and /app.js we just hardcode some paths. You should probably use a nicer way for this.
  get "/" do |ctx|
    send_file ctx, "src/web/index.html"
  end
  
  get "/app.js" do |ctx|
    send_file ctx, "src/web/app.js"
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


