defmodule ShopWeb.ProductHTML do
  use ShopWeb, :html

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
  attr :name, :string, required: true
  attr :id, :string, required: true
  # attr :name, :string, default: "something" <= default value in case
  # we pass nothing

  # Function component
  def product(assigns) do
    ~H"""
    <h1 class="text-xl font-extralight text-teal-700">
      This is the page for the product <span class="font-normal italic text-amber-700">{@name}</span>
      <%!-- This {assigns.name} is equivalent to this {@name} --%> whose ID is
      <span class="font-normal text-amber-700">{@id}</span>
    </h1>
    """
  end

  def no_product(assigns),
    do: ~H"""
    <h1 class="text-xl font-extralight text-red-500">
      There is no product with that ID!
    </h1>
    """

  def product_list_item(assigns) do
    ~H"""
    <li class="text-lime-600 italic">
      <a href={~p"/products/" <> @id}>{@name}</a>
    </li>
    """
  end
end
