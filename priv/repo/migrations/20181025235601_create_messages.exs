defmodule Webchat.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :name, :string
      add :message, :string
      add :room_name, :string

      timestamps()
    end

  end
end
