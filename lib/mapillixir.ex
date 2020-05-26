defmodule Mapillixir do
  use HTTPoison.Base

  def get(path, params, options) do
    url =
      path
      |> url()
      |> add_params_to_url(params)

    case pagination(options) do
      :none -> request_with_pagination(:get, url)
      :stream -> request_stream(:get,  url)
      _ -> request_with_pagination(:get, url)
    end
  end

  defp url(path) do
    "https://a.mapillary.com/v3" <> path
  end

  defp add_params_to_url(url, params) do
    url
    |> URI.parse()
    |> merge_uri_params(params)
    |> String.Chars.to_string()
  end

  defp merge_uri_params(uri, []), do: uri

  defp merge_uri_params(%URI{query: nil} = uri, params) when is_list(params) or is_map(params) do
    uri
    |> Map.put(:query, URI.encode_query(params))
  end

  defp merge_uri_params(%URI{} = uri, params) when is_list(params) or is_map(params) do
    uri
    |> Map.update!(:query, fn q ->
      q
      |> URI.decode_query()
      |> Map.merge(param_list_to_map_with_string_keys(params))
      |> URI.encode_query()
    end)
  end

  defp param_list_to_map_with_string_keys(list) when is_list(list) or is_map(list) do
    for {key, value} <- list, into: Map.new() do
      {"#{key}", value}
    end
  end

  defp pagination(options) do
    Keyword.get(options, :pagination, Application.get_env(:mapillixir, :pagination, nil))
  end

  defp request_stream(_method, url) do # TODO: make method dynamical
    Stream.resource(
      fn -> url end,
      &process_stream/1,
      fn _ -> nil end)
  end

  defp process_stream(nil), do: {:halt, nil}

  defp process_stream(url) do
    {result, next_url} = request_with_pagination(:get, url)
    {[result], next_url}
  end

  defp request_with_pagination(method, url) do
    request!(method, url)
    |> build_pagination_response()
  end

  defp build_pagination_response({_status, body, %HTTPoison.Response{:headers => headers}}) do
    {body, next_link(headers)}
  end

  defp next_link(headers) do
    for {"Link", link_header} <- headers,
        links <- String.split(link_header, ",") do
      Regex.named_captures(~r/<(?<link>.*)>;\s*rel=\"(?<rel>.*)\"/, links)
      |> case do
        %{"link" => link, "rel" => "next"} -> link
        _ -> nil
      end
    end
    |> Enum.filter(&(not is_nil(&1)))
    |> List.first()
  end

  # Override
  def process_response_body(""), do: nil
  def process_response_body(body), do: JSX.decode!(body)

  def process_response(%HTTPoison.Response{status_code: status_code, body: body} = resp),
    do: {status_code, body, resp}
end
