defmodule ShopWeb.ProductController do
  use ShopWeb, :controller

  @products [
    %{id: "1", name: "God of war"},
    %{id: "2", name: "Skyrim"},
    %{id: "3", name: "Diable 4"}
  ]

  def index(conn, _params) do
    # dbg(conn)
    # dbg(params)
    # text(conn, "Hello, Enrique 😀!! - #{Mix.env()}")

    # Verified Routes: provides compile-time checks of
    # router paths against your router by using the ~p sigil
    # conn |> redirect(to: ~p"/wrong")

    conn
    |> assign(:products, @products)
    |> render(:index)
  end

  def show(conn, %{"id" => id}) do
    # %{{"id", id}} = params
    # dbg(id)

    # product = Enum.find(@products, fn p -> p.id == id end)
    product = @products |> Enum.find(&(&1.id == id))

    conn
    |> assign(:product, product)
    |> render(:show)
  end
end
