defmodule WebchatWeb.UserSocket do
  use Phoenix.Socket

  ## Channels
  channel "room:*", WebchatWeb.RoomChannel
  channel "roomnames", WebchatWeb.RoomChannel

  ## Transports
  transport :websocket, Phoenix.Transports.WebSocket

  def connect(params, socket) do
    socket = socket
      |> assign(:nickname, params["nickname"])
      |> assign(:roomname, params["roomname"])
    {:ok, socket}

  end
  
  def connect(socket) do

    {:ok, socket}

  end

  def id(_socket), do: nil
end
