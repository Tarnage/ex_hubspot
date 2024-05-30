defmodule Hubspot.Client do
  @moduledoc ~S"""
  This module is responsible for creating a new client for Hubspot API.

  The client is created using the `Req` library, which is a wrapper around Mint.

  The client is created with the following headers:
  - authorization (Bearer token)
  - accept (application/json)
  - content-type (application/json)

  The client is created with the following options:
  - base_url (rest_url)
  - retry (retry)
  - hs_access_token (hs_access_token)

  The client is created with the following methods:
  - new_client/1
  - new_client/0

  ## Examples
      iex> client = Hubspot.Client.new_client()
      %Req.Request{
        method: :get,
        url: URI.parse(""),
        headers: %{
        "accept" => ["application/json"],
        "authorization" => ["YOUR_ACCESS_TOKEN"],
        "content-type" => ["application/json"]
        },
        body: nil,
        options: %{retry: true, base_url: "https://api.hubapi.com"},
        ...
  """
  @hubspot_base_url "https://api.hubapi.com"

  @spec new_client() :: Req.Request.t()
  def new_client() do
    Req.new(base_url: @hubspot_base_url, retry: false)
    |> add_required_headers()
  end

  defp add_required_headers(client) do
    client
    |> Req.Request.put_header("authorization", "Bearer #{access_token()}")
    |> Req.Request.put_header("accept", "application/json")
    |> Req.Request.put_header("content-type", "application/json")
  end

  defp access_token do
    Application.get_env(:tech_co, :hubspot)[:hs_access_token]
  end
end
