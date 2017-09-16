require "./redis2ws/*"
require "kemal"

module Redis2ws
  SOCKETS = [] of HTTP::WebSocket
  
  get "/" do |ctx|
    "BIEP"
  end
  
  ws "/chat" do |socket|
    # Add the client to SOCKETS list
    SOCKETS << socket

    # Broadcast each message to all clients
    socket.on_message do |message|
      SOCKETS.each { |socket| socket.send message}
    end

    # Remove clients from the list when it’s closed
    socket.on_close do
      SOCKETS.delete socket
    end
  end

  Kemal.run
end


