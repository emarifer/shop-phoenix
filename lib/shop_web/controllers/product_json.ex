defmodule ShopWeb.ProductJSON do
  # To render JSON you don't need to call any macro

  def index(_assigns) do
    # Rendering or responding with JSON is done using a map.
    # Since the `~H` sigil is not used, there is no need to pass `assigns`.
    %{
      data: [
        %{name: "God of war"},
        %{name: "Skyrim"},
        %{name: "Diable 4"}
      ]
    }
  end
end
