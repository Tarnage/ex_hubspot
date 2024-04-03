defmodule Hubspot.OauthRefreshWorkerTest do
  use ExUnit.Case
  alias Hubspot.OauthRefreshWorker

  setup do
    config = %{
      hs_access_token: System.get_env("HS_ACCESS_TOKEN"),
      rest_url: System.get_env("HS_REST_URL"),
      retry: false
    }

    {:ok, pid} = OauthRefreshWorker.start_link(config)
    {:ok, pid: pid}
  end

  test "starts the worker and initializes state", %{pid: pid} do
    assert Process.alive?(pid)
  end

  test "get_client returns a client" do
    client = OauthRefreshWorker.get_client()
    assert %Req.Request{} = client
  end
end
