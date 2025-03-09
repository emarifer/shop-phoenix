defmodule ShopWeb.ApiJSON do
  # To render JSON you don't need to call any macro

  def index(%{products: products}) do
    # Rendering or responding with JSON is done using a map.
    # Since the `~H` sigil is not used, there is no need to pass `assigns`.
    %{products: products}
  end

  # another way:
  # def index(assigns) do
  #   %{products: assigns.products}
  # end
end
