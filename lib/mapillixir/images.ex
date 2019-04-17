defmodule Mapillixir.Image do
  import Mapillixir

  def list(params \\ [], options \\ []) do
    get("/images", params, options)
  end

  def details(key, params \\ [], options \\ []) do
    get("/images/#{key}", params, options)
  end
end
