defmodule ClientTest do
  use ExUnit.Case
  alias ExHubspot.Client

  setup do
    access_token = String.trim(System.get_env("HS_ACCESS_TOKEN"))
    client_secret = String.trim(System.get_env("HS_SECRET"))
    endpoint = String.trim(System.get_env("HS_ENDPOINT"))

    [
      config: %{
        hs_api_endpoint: endpoint,
        access_token: access_token,
        client_secret: client_secret
      }
    ]
  end

  describe "new/1" do
    test "returns a Req struct with correct headers and base_url", %{config: config} do
      request = Client.new(config)

      assert request.options.base_url == config.hs_api_endpoint
      assert request.headers["authorization"] == ["Bearer" <> " " <> config.access_token]
      assert request.headers["accept"] == ["application/json"]
      assert request.headers["content-type"] == ["application/json"]
    end
  end
end
