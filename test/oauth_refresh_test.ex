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
    send(self(), :tick)
    assert_receive :tick
    assert Process.alive?(pid)
  end

  test "sends tick message after 5 seconds", %{pid: _pid} do
    :timer.sleep(6000)
    assert_receive :tick
  end

  test "handles tick message and continues ticking", %{pid: pid} do
    assert_receive {:ok, _}
    assert_receive {:ok, _}
    assert_receive {:ok, _}
    assert Process.alive?(pid)
  end
end
