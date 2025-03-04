defmodule ShopWeb.ProductHTML do
  use ShopWeb, :html

  # def index(assigns) do
  #   ~H"""
  #   <h1 class="text-3xl text-sky-500 font-bold">This is the products listing page!</h1>
  #   """
  # end

  embed_templates "product_html/*"
end
