defmodule ShopWeb.ProductLive.Show do
  use ShopWeb, :live_view

  alias Shop.Products

  def mount(%{"slug" => slug}, _session, socket) do
    product = Products.get_product_by_slug(slug)

    socket = socket |> assign(:product, product)

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <p>- ID: <span class="text-lime-300">{@product.id}</span></p>
    <p>- Console: <span class="text-lime-300 capitalize">{@product.console}</span></p>
    <h1 class="text-xl font-extralight text-accent">
      This is the page for the product - Game:
      <span class="font-normal italic text-amber-700">{@product.name}</span>
    </h1>

    <.back
      navigate={~p"/products-live"}
      class="font-extralight text-slate-400 hover:text-teal-300 ease-in duration-300"
    >
      Back to products listing page
    </.back>
    """
  end
end
