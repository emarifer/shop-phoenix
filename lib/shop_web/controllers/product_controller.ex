defmodule ShopWeb.ProductController do
  use ShopWeb, :controller

  def index(conn, _params) do
    # dbg(conn)
    # dbg(params)
    # text(conn, "Hello, Enrique 😀!! - #{Mix.env()}")
    render(conn, :index)
  end

  def show(conn, %{"id" => id}) do
    # %{{"id", id}} = params
    # dbg(id)

    render(conn, :show, id: id)
  end
end
