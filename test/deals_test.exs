defmodule Hubspot.DealsTest do
  use ExUnit.Case
  alias Hubspot.Deals
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

  test "get_deal_by_id returns deal" do
    deal_id = 16_048_602_507
    {:ok, resp} = Deals.get_deal_by_id(OauthRefreshWorker.get_client(), deal_id)
    assert resp != nil
  end

  test "get_deal_by_id error handling" do
    deal_id = "Not VALID"
    {:error, resp} = Deals.get_deal_by_id(OauthRefreshWorker.get_client(), deal_id)
    assert resp == "Invalid deal id: Not VALID"
  end
end
