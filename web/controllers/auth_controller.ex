defmodule CorpHanger.AuthController do

  use CorpHanger.Web, :controller
  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> redirect(to: "/")
  end
  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    IO.inspect(auth)
    conn
    |> put_flash(:info, "Successfully authenticatede.")
    |> put_session(:current_user, auth)
    |> redirect(to: "/")
  end
  
end
