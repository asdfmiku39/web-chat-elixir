defmodule WebchatWeb.RoomChannel do
  use WebchatWeb, :channel

  def join("room:" <> roomname, message, socket) do
    send(self(), :after_join)
    {:ok, socket}
  end

  def join("roomnames", message, socket) do
    send(self(), :after_join)
    {:ok, socket}
  end

  def handle_in("rooms", message, socket) do
      {:noreply, socket}
  end

  def handle_in("shout", message, socket) do
    Webchat.Message.changeset(%Webchat.Message{}, 
      %{name: socket.assigns.nickname, message: message,
        room_name: socket.assigns.roomname}) |> Webchat.Repo.insert!

    broadcast socket, "shout", %{name: socket.assigns.nickname, message: message}
    {:noreply, socket}
    
  end

  def handle_info(:after_join, socket) do
    Webchat.Message.get_messages(socket.assigns.roomname)
    |> Enum.each(fn msg -> push(socket, "shout", %{
          name: msg.name,
          message: msg.message,
        }) end)
    Webchat.Message.get_rooms()
    |> Enum.each(fn room -> push(socket, "rooms", %{
          roomname: room,
        }) end)

    {:noreply, socket}
  end
end
