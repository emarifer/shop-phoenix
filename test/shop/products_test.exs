defmodule Shop.ProductsTest do
  # ↓↓↓ To test the `Products` context. ↓↓↓
  use Shop.DataCase

  alias Shop.Products

  describe "products" do
    # ↓↓↓  a schema struct for `Product`. ↓↓↓
    alias Shop.Products.Product

    import Shop.ProductsFixtures

    @invalid_attrs %{name: "in", console: nil}

    test "list_products/0 returns all products" do
      product = product_fixture()
      assert Products.list_products() == [product]
    end

    test "create_product/1 with valid data creates a product" do
      valid_attrs = %{name: "some game", console: "pc"}

      assert {:ok, %Product{} = product} = Products.create_product(valid_attrs)
      assert product.name == "some game"
      assert product.console == :pc
      assert product.slug == "some-game"
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Products.create_product(@invalid_attrs)
    end
  end
end
