defmodule Hubspot.PropertiesTest do
  use ExUnit.Case
  alias Hubspot.Properties
  alias Hubspot.OauthRefreshWorker

  setup do
    config = %{
      hs_access_token: Application.get_env(:ex_hubspot, :hs_access_token),
      rest_url: Application.get_env(:ex_hubspot, :rest_url),
      retry: Application.get_env(:ex_hubspot, :retry)
    }

    {:ok, pid} = OauthRefreshWorker.start_link(config)
    {:ok, pid: pid}
  end

  test "get_properties returns meta" do
    meta = Properties.get_properties_by_object(OauthRefreshWorker.get_client(), "Deals")
    assert meta != nil
  end

  test "get_properties get all groups" do
    meta = Properties.get_properties_by_group(OauthRefreshWorker.get_client(), "Deals")
    assert Map.has_key?(meta, "results")
  end

  test "get_properties get group by name" do
    group_name = "job_order_#4"

    meta =
      Properties.get_properties_by_group(OauthRefreshWorker.get_client(), "Deals", group_name)

    assert Map.get(meta, "name") == group_name
  end

  test "get_all_properties returns meta" do
    meta = Properties.get_all_properties(OauthRefreshWorker.get_client(), "Deals")
    IO.inspect(meta)
    assert meta != nil
  end
end
