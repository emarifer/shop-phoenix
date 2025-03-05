defmodule ShopWeb.RandomController do
  use ShopWeb, :controller

  def random(conn, _params) do
    # For speed you can use these functions directly,
    # but it is usual to use the `render` function.
    # text(conn, "Hello everyone!!")
    # html(conn, "<html><body><h1>Hello everyone!!</h1></body></html>")
    # json(conn, %{message: "Hello everyone!!"})
    render(conn, :random)
    # This requires a module (`ShopWeb.ProductHTML`) in a
    # `random_html.ex` file that can either render an inline
    # template directly or call template files
    # (with the extension .html.ex) located in a directory
    # called `random_html` (such as the file `random_html.ex`).
    # This is done when a single controller handles multiple views.
  end
end
