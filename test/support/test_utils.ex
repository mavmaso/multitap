defmodule Multitap.TestUtils do

  import Plug.Conn
  import Phoenix.ConnTest

  alias Multitap.Accounts

  def login(conn, user) do
    token = Accounts.generate_user_session_token(user)

    conn
    |> Map.merge(%{secret_key_base: MultitapWeb.Endpoint.config(:secret_key_base)})
    |> init_test_session(%{})
    |> put_session(:user_token, token)
  end
end
