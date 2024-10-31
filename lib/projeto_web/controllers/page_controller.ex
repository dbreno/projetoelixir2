defmodule ProjetoWeb.PageController do
  use ProjetoWeb, :controller
  alias Projeto.ApiClient

  def index(conn, _params) do
    render(conn, :index, layout: false)
  end

  def characters(conn, params) do
    case ApiClient.get_all_characters(params) do
      {:ok, characters} when is_list(characters) ->
        render(conn, :characters, characters: characters)

      {:error, reason} ->
        render(conn, "error.html", reason: reason)
    end
  end

  def episodes(conn, params)do
    case ApiClient.get_all_episodes(params) do
      {:ok, episodes} when is_list(episodes) ->
        render(conn, :episodes, episodes: episodes)

      {:error, reason} ->
        render(conn, "error.html", reason: reason)
    end
  end

  def locations(conn, params) do

    IO.inspect(params, label: "Parâmetros Recebidos no Controller - Locations")

    case ApiClient.get_all_locations(params) do
      {:ok, locations} when is_list(locations) ->
        render(conn, :locations, locations: locations)
      {:error, reason} ->
        IO.puts("Erro ao buscar locations: #{reason}")
        render(conn, "error.html", reason: reason)
    end
  end
end
