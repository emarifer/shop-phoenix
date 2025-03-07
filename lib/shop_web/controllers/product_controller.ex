defmodule ShopWeb.ProductController do
  use ShopWeb, :controller

  alias Shop.{Repo, Product}

  # Data mock
  # @products [
  #   %{id: "1", name: "God of war"},
  #   %{id: "2", name: "Skyrim"},
  #   %{id: "3", name: "Diable 4"}
  # ]

  def index(conn, _params) do
    # dbg(conn)
    # dbg(params)
    # text(conn, "Hello, Enrique 😀!! - #{Mix.env()}")

    # Verified Routes: provides compile-time checks of
    # router paths against your router by using the ~p sigil
    # conn |> redirect(to: ~p"/wrong")

    products = Repo.all(Product)

    conn
    |> assign(:products, products)
    |> render(:index)
  end

  def show(conn, %{"slug" => slug}) do
    # %{{"id", id}} = params
    # dbg(id)

    # product = Enum.find(@products, fn p -> p.id == id end)
    # product = @products |> Enum.find(&(&1.id == id))

    product = Repo.get_by(Product, slug: slug)

    conn
    |> assign(:product, product)
    |> render(:show)
  end
end

# REFERENCES:
# https://hexdocs.pm/phoenix_live_view/Phoenix.Component.html
# https://hexdocs.pm/phoenix_live_view/Phoenix.Component.html#sigil_H/2
# https://hexdocs.pm/eex/EEx.html
# https://developer.mozilla.org/en-US/docs/Glossary/Slug
# https://www.prisma.io/dataguide/types/relational/what-are-database-migrations#what-are-the-advantages-of-migration-tools
# https://hexdocs.pm/phoenix/ecto.html#data-persistence
# https://hexdocs.pm/phoenix/Mix.Tasks.Phx.Gen.html
# https://hexdocs.pm/ecto/crud.html

# mix phx.gen.schema Product products name slug:unique console:enum:pc:xbox:playstation:nintendo

#   iex -S mix phx.server

#   game = %Shop.Product{name: "Diablo 4", slug: "diablo-4", console: "pc"} ==>

#   %Shop.Product{
#     __meta__: #Ecto.Schema.Metadata<:built, "products">,
#     id: nil,
#     name: "Diablo 4",
#     console: "pc",
#     slug: "diablo-4",
#     inserted_at: nil,
#     updated_at: nil
#   }

#   changeset = Product.changeset(%Product{}, %{name: "Diablo 4"}) ==>

#   #Ecto.Changeset<
#     action: nil,
#     changes: %{name: "Diablo 4"},
#     errors: [
#       slug: {"can't be blank", [validation: :required]},
#       console: {"can't be blank", [validation: :required]}
#     ],
#     data: #Shop.Product<>,
#     valid?: false,
#     ...
#   >

#   changeset.valid? ==> false

#   check required validation
#   changeset.errors ==>
#   [
#     slug: {"can't be blank", [validation: :required]},
#     console: {"can't be blank", [validation: :required]}
#   ]

#   type validation:
#   changeset = Product.changeset(%Product{}, %{name: 12}) ==>
#   #Ecto.Changeset<
#     action: nil,
#     changes: %{},
#     errors: [
#       slug: {"can't be blank", [validation: :required]},
#       console: {"can't be blank", [validation: :required]},
#       name: {"is invalid", [type: :string, validation: :cast]}
#     ],
#     data: #Shop.Product<>,
#     valid?: false,
#     ...
#   >

#   changeset = Product.changeset(%Product{}, %{name: "Diablo 4", console: "random"}) ==>
#   #Ecto.Changeset<
#     action: nil,
#     changes: %{name: "Diablo 4"},
#     errors: [
#       console: {"is invalid",
#        [
#          type: {:parameterized,
#           {Ecto.Enum,
#            %{
#              on_load: %{
#                "nintendo" => :nintendo,
#                "pc" => :pc,
#                "playstation" => :playstation,
#                "xbox" => :xbox
#              },
#              type: :string,
#              embed_as: :self,
#              mappings: [
#                pc: "pc",
#                xbox: "xbox",
#                playstation: "playstation",
#                nintendo: "nintendo"
#              ],
#              on_cast: %{
#                "nintendo" => :nintendo,
#                "pc" => :pc,
#                "playstation" => :playstation,
#                "xbox" => :xbox
#              },
#              on_dump: %{
#                pc: "pc",
#                xbox: "xbox",
#                playstation: "playstation",
#                nintendo: "nintendo"
#              }
#            }}},
#          validation: :inclusion,
#          enum: ["nintendo", "pc", "playstation", "xbox"]
#        ]}
#     ],
#     data: #Shop.Product<>,
#     valid?: false,
#     ...
#   >

#   changeset = Product.changeset(%Product{}, %{name: "Diablo 4", console: "pc"}) ==>
#   #Ecto.Changeset<
#     action: nil,
#     changes: %{name: "Diablo 4", console: :pc},
#     errors: [],
#     data: #Shop.Product<>,
#     valid?: true,
#     ...
#   >

#   changeset.valid? ==> true

#   changes that will actually be inserted into the database:
#   changeset.changes ==> %{name: "Diablo 4", console: :pc}
#   `validate_length(:name, min: 3)` ==>
#   changeset = Product.changeset(%Product{}, %{name: "Di", console: "pc"}) ==>
#   changeset.errors ==>
#   [
#     name: {"should be at least %{count} character(s)",
#      [count: 3, validation: :length, kind: :min, type: :string]}
#   ]

#   QUERY (example):
#   ================
#   Repo.all(from p in Product, where: ilike(p.console, "%x%") ==>
#   [
#     %Shop.Product{
#       __meta__: #Ecto.Schema.Metadata<:loaded, "products">,
#       id: 2,
#       name: "Diablo 4",
#       console: :xbox,
#       slug: "diablo-4",
#       inserted_at: ~U[2025-03-07 11:40:24Z],
#       updated_at: ~U[2025-03-07 11:40:24Z]
#     }
#   ]
