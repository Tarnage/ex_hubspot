defmodule Hubspot.Deals do
  @deal_url "/crm/v3/objects/deals"

  @properties "roles_jo1,client_job_title,roles_jo2,accommodation_description"

  def retrieve_deal(client, deal_id) do
    endpoint = client.options.base_url <> "/" <> @deal_url <> "/#{deal_id}"

    {:ok, resp} =
      client
      |> Req.get(url: @deal_url <> "/#{deal_id}", params: %{properties: @properties})

    resp.body
  end

  def update_deal(client, deal_id) do
  end
end
