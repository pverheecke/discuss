defmodule Discuss.AuthController do
    use Discuss.Web, :controller
    alias Discuss.User
    plug Ueberauth

    def callback(%{assigns: %{ueberauth_auth: auth}} = conn, params) do
        user_params = %{token: auth.credentials.token, email: auth.info.email, provider: "github"}
        changeset = User.changeset(%User{}, user_params)

        signin(conn, changeset)
    end

    defp signin(conn, changeset) do
        
    end

    defp insert_or_update_user(changeset) do
        case Repo.get_by(User, email: changeset.changes.email) do
            nil -> 
                Repo.insert(changeset)
            user ->
                {:ok, user}
        end
    end
end