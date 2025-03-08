defmodule Shop.Products do
  @moduledoc """
  The Products context.
  """

  alias Shop.Repo
  alias Shop.Products.Product

  def list_products, do: Repo.all(Product)

  def get_product_by_slug(slug) when is_binary(slug) do
    Repo.get_by(Product, slug: slug)
  end

  def find_product_by_id(id), do: Repo.get(Product, id)

  # https://stackoverflow.com/questions/34563884/what-does-the-double-backslash-mean-in-a-function-parameter-in-elixir
  def create_product(attrs \\ %{}) do
    %Product{}
    |> Product.changeset(attrs)
    |> Repo.insert()
  end

  def delete_product(%Product{} = product) do
    # ↑↑↑ see note below ↑↑↑
    Repo.delete(product)
  end
end

# Test functions:
# iex -S mix phx.server

# REFERENCES:
# `def delete_product(%Product{} = product)` It's better ==>
# Elixir forum:
# "As a side note, even though `def something(c = %Plug.Conn{})`
# and `def something(%Plug.Conn{} = c)` are technically the same,
# I always strongly push for the latter, since it’s more intuitive
# and more in line with pattern matching inside of a function
# (from right to left)":
# https://elixirforum.com/t/how-to-think-about-pattern-matching-vs-type-checking/20864/6

# mix phx.gen.context Consoles Console consoles name:string price:integer
# mix ecto.migrate
# mix ecto.rollback # to reverse migration

# mix phx.gen.html Promotions Promotion promotions name:string code:string:unique expires_at:utc_datetime

# The generator creates a definition of the props required by the form,
# but not of the form itself, which is defined in the `promotion_html` folder.
# defmodule ShopWeb.PromotionHTML do
#   use ShopWeb, :html

#   embed_templates "promotion_html/*"

#   @doc """
#   Renders a promotion form.
#   """
#   attr :changeset, Ecto.Changeset, required: true <===
#   attr :action, :string, required: true <===

#   def promotion_form(assigns) <===
# end

# https://hexdocs.pm/phoenix/Mix.Tasks.Phx.Gen.html
# https://hexdocs.pm/phoenix/Mix.Tasks.Phx.Gen.Context.html
# https://hexdocs.pm/phoenix/Mix.Tasks.Phx.Gen.Schema.html#module-attributes
# https://hexdocs.pm/phoenix/Mix.Tasks.Phx.Gen.Html.html
