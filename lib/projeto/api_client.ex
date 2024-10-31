defmodule Projeto.ApiClient do
  use HTTPoison.Base

  @api_url "https://rickandmortyapi.com/api/"

  def get_all_characters(filters \\ %{}) do
    # Constrói a query string sem o filtro de `origin`, que será aplicado manualmente
    filters_for_api = Map.drop(filters, ["origin"])
    filters_query = Enum.map(filters_for_api, fn {key, value} -> "#{key}=#{URI.encode(value)}" end)
      |> Enum.join("&")

    url = "#{@api_url}character/?#{filters_query}"
    fetch_all_characters(url, [], filters["origin"])
  end

  defp fetch_all_characters(url, acc, origin_filter \\ nil) do
    case get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        %{"results" => characters, "info" => info} = Jason.decode!(body)

        # Aplica o filtro de origin manualmente, se necessário
        filtered_characters = case origin_filter do
          nil -> characters
          _ -> Enum.filter(characters, fn character ->
            String.contains?(String.downcase(character["origin"]["name"]), String.downcase(origin_filter))
          end)
        end
        new_acc = acc ++ filtered_characters

        case info["next"] do
          nil -> {:ok, new_acc}
          next_url -> fetch_all_characters(next_url, new_acc, origin_filter)
        end

      {:ok, %HTTPoison.Response{status_code: 404}} -> {:ok, []}  # Retorna lista vazia se não houver resultados

      {:ok, %HTTPoison.Response{status_code: status}} -> {:error, "Error: #{status}"}
      {:error, %HTTPoison.Error{reason: reason}} -> {:error, reason}
    end
  end

  def get_all_episodes(filters \\ %{}) do
    case Map.get(filters, "id") do
      nil -> buscar_com_filtros(filters)
      "" -> buscar_com_filtros(filters)
      id -> buscar_por_id(id)
    end
  end

  defp buscar_por_id(id) do
    url = "#{@api_url}episode/#{id}"
    case get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        episode = Jason.decode!(body)
        {:ok, [episode]}
      {:ok, %HTTPoison.Response{status_code: 404}} -> {:ok, []}
      {:ok, %HTTPoison.Response{status_code: status}} -> {:error, "Error: #{status}"}
      {:error, %HTTPoison.Error{reason: reason}} -> {:error, reason}
    end
  end

  defp buscar_com_filtros(filters) do
    {episode_code, filters} = Map.pop(filters, "episode_code")

    # Mapeia o `episode_code` para `episode`, que é a chave esperada pela API
    filters = if episode_code not in [nil, ""] do
      Map.put(filters, "episode", episode_code)
    else
      filters
    end

    # Remove campos nulos ou vazios da consulta
    sanitized_filters = Enum.reject(filters, fn {_, value} -> value in [nil, ""] end)
    filters_query = Enum.map(sanitized_filters, fn {key, value} -> "#{key}=#{URI.encode(value)}" end)
      |> Enum.join("&")

    url = "#{@api_url}episode/?#{filters_query}"

    fetch_all_episodes(url, [])
  end

  defp fetch_all_episodes(url, acc) do
    case get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        %{"results" => episodes, "info" => info} = Jason.decode!(body)
        new_acc = acc ++ episodes

        case info["next"] do
          nil -> {:ok, new_acc}
          next_url -> fetch_all_episodes(next_url, new_acc)
        end

      {:ok, %HTTPoison.Response{status_code: 404}} -> {:ok, []}
      {:ok, %HTTPoison.Response{status_code: status}} -> {:error, "Error: #{status}"}
      {:error, %HTTPoison.Error{reason: reason}} -> {:error, reason}
    end
  end

  def get_all_locations(filters \\ %{}) do
    IO.inspect(filters, label: "Filtros Recebidos em get_all_locations")
    sanitized_filters = filters
       |> Enum.reject(fn {_, value} -> value in [nil, ""] end)
       |> Enum.into(%{}, fn {key, value} -> {to_string(key), value} end)

    filters_query = URI.encode_query(sanitized_filters)
    url = "#{@api_url}location/?#{filters_query}"

    IO.puts("Request URL para Location: #{url}")
    fetch_all_locations(url, [])
 end

 defp fetch_all_locations(url, acc) do
  IO.puts("Fetching URL: #{url}")
  case get(url) do
     {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        %{"results" => locations, "info" => info} = Jason.decode!(body)
        new_acc = acc ++ locations

        IO.inspect(new_acc, label: "Locations Obtidas")
        case info["next"] do
           nil -> {:ok, new_acc}
           next_url -> fetch_all_locations(next_url, new_acc)
        end
     {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts("Nenhuma location encontrada para os filtros.")
        {:ok, []}
     {:ok, %HTTPoison.Response{status_code: status}} ->
        IO.puts("Código de status inesperado: #{status}")
        {:error, "Error: #{status}"}
     {:error, %HTTPoison.Error{reason: reason}} ->
        IO.puts("Erro na requisição HTTP: #{inspect(reason)}")
        {:error, reason}
  end
end


end
