defmodule VanillaPhx.Posts do
  use VanillaPhx.Web, :model

  schema "posts" do
    field :title, :string
    field :body, :string
    field :created_at, Ecto.DateTime
    field :updated_at, Ecto.DateTime
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :body])
    |> validate_required([:title, :body])
  end
end
