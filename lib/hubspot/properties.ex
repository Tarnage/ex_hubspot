defmodule Hubspot.Properties do
  @properties_endpoint_v3 "/crm/v3/properties/"

  def get_all_properties(client, object) do
    endpoint = client.options.base_url <> @properties_endpoint_v3 <> "#{object}"
    {:ok, resp} = client |> Req.get(url: endpoint)
    resp.body
  end

  def get_properties_by_object(client, object) do
    endpoint = client.options.base_url <> @properties_endpoint_v3 <> "#{object}/batch/read"
    {:ok, resp} = client |> Req.post(url: endpoint)
    resp.body
  end

  def get_properties_by_group(client, object) do
    endpoint = client.options.base_url <> @properties_endpoint_v3 <> "#{object}/groups/"
    {:ok, resp} = client |> Req.get(url: endpoint)
    resp.body
  end

  def get_properties_by_group(client, object, group) do
    endpoint =
      client.options.base_url <>
        @properties_endpoint_v3 <> "#{object}/groups/" <> URI.encode(group, &(&1 != ?#))

    {:ok, resp} = client |> Req.get(url: endpoint)
    resp.body
  end
end
