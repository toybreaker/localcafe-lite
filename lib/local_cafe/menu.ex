defmodule LocalCafe.Menu do
  alias LocalCafe.Menu.Item

  use NimblePublisher,
    build: Item,
    from: Application.app_dir(:local_cafe, "priv/menu/**/*.md"),
    as: :items

  # The @items variable is first defined by NimblePublisher.
  # Sort items by position (0-indexed, lower numbers first), then alphabetically by title.
  # Items without a position default to 999999 (appearing at the end).
  @items Enum.sort_by(@items, &{&1.position || 999999, &1.title})

  # Let's also get all tags
  @tags @items |> Enum.flat_map(& &1.tags) |> Enum.uniq() |> Enum.sort()

  # And finally export them
  def all_items, do: @items
  def all_tags, do: @tags
end
