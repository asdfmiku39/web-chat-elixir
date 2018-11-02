defmodule Webchat.Message do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  schema "messages" do
    field :message, :string
    field :name, :string
    field :room_name, :string

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:name, :message, :room_name])
    |> validate_required([:name, :message, :room_name])

  end

  def get_messages(roomname, limit \\ 20) do
    Webchat.Message |> where(room_name: ^roomname) |>
      Webchat.Repo.all(limit: limit)

  end
  def get_rooms(limit \\ 20) do

    Webchat.Message |> group_by([p], p.room_name) |> 
      select([p], p.room_name)|> Webchat.Repo.all(limit: limit)

  end
end
