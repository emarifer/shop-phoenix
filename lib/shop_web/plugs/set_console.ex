defmodule ShopWeb.Plugs.SetConsole do
  import Plug.Conn

  @thirty_days_in_seconds 60 * 60 * 24 * 30
  @valid_consoles ["pc", "xbox", "playstation", "nintendo"]

  def init(default_console), do: default_console

  def call(%Plug.Conn{:params => %{"console" => console}} = conn, _default_console)
      when console in @valid_consoles do
    conn
    |> assign(:console, console)
    |> put_resp_cookie("console", console, max_age: @thirty_days_in_seconds)
  end

  def call(%Plug.Conn{cookies: %{{"console", console}}} = conn, _default_console)
      when console in @valid_consoles do
    conn
    |> assign(:console, console)
  end

  def call(conn, default_console) do
    conn
    |> assign(:console, default_console)
    |> put_resp_cookie("console", default_console, max_age: @thirty_days_in_seconds)
  end
end
