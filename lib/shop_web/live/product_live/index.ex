defmodule ShopWeb.ProductLive.Index do
  use ShopWeb, :live_view

  alias Shop.Products

  def mount(_params, _session, socket) do
    products = Products.list_products()

    socket = socket |> assign(:products, products)

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div>
      <h1 class="text-3xl font-bold text-sky-500">This is the Product Live Page</h1>

      <ul class="list-disc list-inside mt-10">
        <li :for={product <- @products} class="text-accent italic hover:text-base-content w-fit">
          <.link patch={~p"/products-live/#{product.slug}"}>{product.name}</.link>
        </li>
      </ul>

      <.back
        navigate={~p"/"}
        class="font-extralight text-slate-400 hover:text-teal-300 ease-in duration-300"
      >
        Back to Home Page
      </.back>
    </div>
    """
  end
end

# Live navigation:
# https://hexdocs.pm/phoenix_live_view/live-navigation.html
