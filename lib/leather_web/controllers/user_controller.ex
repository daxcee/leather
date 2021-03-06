defmodule LeatherWeb.UserController do
  @moduledoc false

  use LeatherWeb, :controller

  plug(
    :forbid_authenticated_users
    when action in [:login, :login_form, :signup, :signup_form]
  )

  alias Leather.Auth
  alias Leather.Repo
  alias Leather.User

  def login_form(conn, _params) do
    render(conn, "login.html")
  end

  def signup_form(conn, _params) do
    changeset = User.registration_changeset(%User{})
    render(conn, "signup.html", changeset: changeset)
  end

  def login(conn, %{"session" => %{"email" => email, "password" => pass}}) do
    case Auth.login_by_email_and_pass(conn, email, pass, repo: Repo) do
      {:ok, conn} ->
        conn
        |> redirect(to: "/")

      {:error, _reason, conn} ->
        conn
        |> put_flash(:error, "Invalid email/password combination")
        |> render("login.html")
    end
  end

  def logout(conn, _) do
    conn
    |> Auth.logout()
    |> redirect(to: "/")
  end

  def signup(conn, %{"user" => user_params}) do
    changeset = User.registration_changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> Auth.login(user)
        |> put_flash(:info, "#{user.email} created!")
        |> redirect(to: "/")

      {:error, changeset} ->
        render(conn, "signup.html", changeset: changeset)
    end
  end

  defp require_authentication(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in to access this page.")
      |> redirect(to: user_path(conn, :signup))
      |> halt()
    end
  end

  defp forbid_authenticated_users(conn, _opts) do
    if conn.assigns.current_user do
      conn
      |> redirect(to: "/")
      |> halt()
    else
      conn
    end
  end
end
