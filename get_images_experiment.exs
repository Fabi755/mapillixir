Mapillixir.Image.list([bbox: "9.622307,52.392940,9.648743,52.407865"], [pagination: :stream]) |> IO.inspect |> Enum.map(fn result -> result["features"] |> Enum.map(fn feature -> feature["properties"]["key"] |> Enum.join("\n") end) end) |> Enum.map() |> Enum.join("\n")


# =======

# Letter
File.write!("letter.txt", Mapillixir.Image.list([bbox: "9.622307,52.392940,9.648743,52.407865"], [pagination: :stream]) |> Enum.map(fn result -> result["features"] |> Enum.map(fn feature -> feature["properties"]["key"] end) end) |> Enum.concat() |> Enum.map(fn key -> "https://images.mapillary.com/#{key}/thumb-2048.jpg" end) |> Enum.join("\n"))

# Goslar
File.write!("goslar.txt", Mapillixir.Image.list([bbox: "10.403023,51.897258,10.467396,51.939609"], [pagination: :stream]) |> Enum.map(fn result -> result["features"] |> Enum.map(fn feature -> feature["properties"]["key"] end) end) |> Enum.concat() |> Enum.map(fn key -> "https://images.mapillary.com/#{key}/thumb-2048.jpg" end) |> Enum.join("\n"))


# =======

File.write!("letter.txt", \ 
	Mapillixir.Image.list([bbox: "9.622307,52.392940,9.648743,52.407865"], [pagination: :stream]) \
	|> Enum.map(fn result -> result["features"] |> Enum.map(fn feature -> feature["properties"]["key"] end) end) \
	|> Enum.concat() \
	|> Enum.map(fn key -> "https://images.mapillary.com/#{key}/thumb-2048.jpg" end) \
	|> Enum.join("\n") \
)


# =======

|> Enum.map(fn feature -> feature["properties"]["key"] end)



%{
   [
     %{
       "geometry" => %{
         "coordinates" => [9.6224731, 52.4071075],
         "type" => "Point"
       },
       "properties" => %{
         "ca" => 243.29248046875,
         "camera_make" => "HUAWEI",
         "camera_model" => "CLT-L09",
         "captured_at" => "2018-05-21T13:19:51.125Z",
         "key" => "kocAfmIcBLE4N1uVpeb6SQ",
         "pano" => false,
         "sequence_key" => "2oeBf2MESymPNxcoo8Vt6w",
         "user_key" => "djtqy7974-L5w9rJU57pmg",
         "username" => "cageythree"
       },
       "type" => "Feature"
     },
    ]



[
  %{
    "geometry" => %{"coordinates" => [9.6224731, 52.4071075], "type" => "Point"},
    "properties" => %{
      "ca" => 243.29248046875,
      "camera_make" => "HUAWEI",
      "camera_model" => "CLT-L09",
      "captured_at" => "2018-05-21T13:19:51.125Z",
      "key" => "kocAfmIcBLE4N1uVpeb6SQ",
      "pano" => false,
      "sequence_key" => "2oeBf2MESymPNxcoo8Vt6w",
      "user_key" => "djtqy7974-L5w9rJU57pmg",
      "username" => "cageythree"
    },
    "type" => "Feature"
  },