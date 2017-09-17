require "./spec_helper"

describe Redis2ws do
  it "will serve the main page" do
    get "/"
    response.body.should contain("WebSockets Demo")
  end

  # The below test doesn't work yet because the testing library can't handle websockets (yet)
  pending "forwards redis messages published on 'mychannel' to the connected sockets" do
    redis = Redis.new
    redis.publish("mychannel","Message contents")
    ws "/eventstream"
  end
end
