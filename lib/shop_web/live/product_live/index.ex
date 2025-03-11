defmodule ShopWeb.ProductLive.Index do
  use ShopWeb, :live_view

  alias Shop.Products

  def mount(_params, _session, socket) do
    products = Products.list_products()

    # %{id => likes}
    # e.g: %{1 => 2, 2 => -3, 2 => 5}
    likes =
      products
      |> Enum.map(fn p -> {p.id, 0} end)
      |> Map.new()

    socket =
      socket
      |> assign(:products, products)
      |> assign(:likes, likes)

    {:ok, socket}
  end

  def handle_event("like", %{"id" => id}, socket) do
    id = String.to_integer(id)

    likes = Map.put(socket.assigns.likes, id, socket.assigns.likes[id] + 1)

    socket =
      socket
      |> assign(:likes, likes)

    {:noreply, socket}
  end

  def handle_event("dislike", %{"id" => id}, socket) do
    id = String.to_integer(id)

    likes = Map.put(socket.assigns.likes, id, socket.assigns.likes[id] - 1)

    socket =
      socket
      |> assign(:likes, likes)

    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
    <div>
      <h1 class="text-3xl font-bold text-sky-500">This is the Product Live Page</h1>

      <ul class="list-disc list-inside mt-10">
        <li
          :for={product <- @products}
          class="text-accent italic hover:text-base-content w-fit flex gap-5 items-center"
        >
          <.link patch={~p"/products-live/#{product.slug}"}>{product.name}</.link>
          •&nbsp&nbsp&nbspLikes: {@likes[product.id]}
          <.icon
            name="hero-hand-thumb-down-micro"
            class="cursor-pointer hover:text-amber-400"
            phx-click="dislike"
            phx-value-id={product.id}
          />
          <.icon
            name="hero-hand-thumb-up-micro"
            class="cursor-pointer hover:text-purple-500"
            phx-click="like"
            phx-value-id={product.id}
          />
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

# liveSocket.enableLatencySim(500) in console (500ms)
# liveSocket.disableLatencySim() in console:
# https://youtu.be/f-qfm9Syh0Q?si=5B_m9umQIscPg89c&t=1766
