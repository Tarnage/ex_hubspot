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

      iex> config = %{rest_url: "https://api.hubapi.com", hs_access_token: "YOUR_ACCESS_TOKEN", retry: true}
      %{
        retry: true,
        rest_url: "https://api.hubapi.com",
        hs_access_token: "YOUR_ACCESS_TOKEN"
      }
      iex> client = Hubspot.Client.new_client(config)
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
  alias Hubspot.OauthRefreshWorker
  defstruct [:rest_url, :hs_access_token, :retry]

  @type client_config :: %__MODULE__{
          rest_url: String.t(),
          hs_access_token: String.t(),
          retry: boolean()
        }

  @type t :: Req.Request.t()

  @spec new_client(client_config) :: Req.Request.t()
  def new_client(%{
        rest_url: rest_url,
        hs_access_token: hs_access_token,
        retry: retry
      }) do
    Req.new(base_url: rest_url, retry: retry)
    |> Req.Request.put_header("authorization", "Bearer #{hs_access_token}")
    |> Req.Request.put_header("accept", "application/json")
    |> Req.Request.put_header("content-type", "application/json")
  end

  def new_client do
    {client, _state} = OauthRefreshWorker.get_client()
    client
  end
end
