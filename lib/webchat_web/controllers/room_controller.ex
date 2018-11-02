defmodule WebchatWeb.RoomController do
  use WebchatWeb, :controller

  def create(conn, params) do
    roomname = params["room"]["roomname"]

    conn
    |> redirect(to: "/rooms/#{roomname}")
  end

  def show(conn, params) do
    conn
    |> render(WebchatWeb.RoomView, "chatroom.html")
  end
end
