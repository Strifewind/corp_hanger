defmodule CorpHanger.AuthController do
  use CorpHanger.Web, :controller
  require IEx

  alias CorpHanger.UseCases.Authentication

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> redirect(to: "/")
  end
  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    character = Authentication.character(auth)
    IO.inspect(character)
    conn
    |> put_flash(:info, "Successfully authenticated.")
    |> Guardian.Plug.sign_in(character)
    |> redirect(to: "/")
  end

  def delete(conn, _params) do
    Guardian.Plug.sign_out(conn)
    |> put_flash(:info, "Logged out successfully.")
    |> redirect(to: "/")
  end

end
