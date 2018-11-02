defmodule WebchatWeb.RoomChannelTest do
  use WebchatWeb.ChannelCase

  alias WebchatWeb.RoomChannel

  setup do
    {:ok, _, socket} =
      socket("user_id", %{roomname: "dada", nickname: "dqeqr"})
      |> subscribe_and_join(RoomChannel, "room:"<>"dada")

    {:ok, socket: socket}
  end


  test "shout broadcasts to room:*", %{socket: socket} do

    push(socket, "shout","hello")
    nickname = socket.assigns.nickname
    roomname = socket.assigns.roomname
    assert_receive %Phoenix.Socket.Broadcast{
       topic: "room:"<>roomname,
       event: "shout",
       payload: %{message: "hello", name: nickname}}

  end


  test "broadcasts are pushed to the client", %{socket: socket} do
    broadcast_from! socket, "broadcast",  %{"message" => "hello"}
    assert_push "broadcast",  %{"message" => "hello"}
  end
end
