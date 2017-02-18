defmodule CorpHanger.AuthController do
  use CorpHanger.Web, :controller

  alias CorpHanger.UseCases.Authentication

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> redirect(to: "/")
  end
  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    character = Authentication.character(auth)
    conn
    |> put_flash(:info, "Successfully authenticated.")
    |> Guardian.Plug.sign_in(character)
    |> redirect(to: "/")
  end

end
