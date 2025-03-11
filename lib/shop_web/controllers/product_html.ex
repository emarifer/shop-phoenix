defmodule ShopWeb.ProductHTML do
  use ShopWeb, :html
  # ↑↑↑ With this macro the CoreComponents are also imported ↑↑↑

  alias Shop.Products.Product

  # Definition of online template:
  # def index(assigns) do
  #   ~H"""
  #   <h1 class="text-3xl text-sky-500 font-bold">This is the products listing page!</h1>
  #   """
  # end

  embed_templates "product_html/*"

  # Defining the props (assigns) that the function component will use.
  # Attribute definitions in function components must
  # be above the components that will use them:
  # attr :name, :string, required: true
  # attr :id, :string, required: true
  # attr :name, :string, default: "something" <= default value in case
  # we pass nothing

  attr :product, Product, required: true

  # Function component
  def product(assigns) do
    ~H"""
    <p>- ID: <span class="text-lime-300">{@product.id}</span></p>
    <p>- Console: <span class="text-lime-300 capitalize">{@product.console}</span></p>
    <h1 class="text-xl font-extralight text-accent">
      This is the page for the product - Game:
      <span class="font-normal italic text-amber-700">{@product.name}</span>
    </h1>
    """
  end

  def no_product(assigns),
    do: ~H"""
    <h1 class="text-xl font-extralight text-red-500">
      There is no product with that Slug!
    </h1>
    """

  def product_list_item(assigns) do
    ~H"""
    <li class="text-accent italic hover:text-base-content w-fit">
      <.link href={~p"/products/#{@product.slug}"}>{@product.name}</.link>
    </li>
    """
  end
end
