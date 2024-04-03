defmodule Hubspot.OauthRefreshWorker do
  alias Hubspot.Client
  require Logger
  use GenServer

  def start_link(config) do
    config = if is_list(config), do: Map.new(config), else: config

    for {k, v} <- config, is_nil(v) do
      raise ArgumentError, "Missing :ex_husbpot required config key: #{k}"
    end

    Logger.debug("Starting Hubspot OauthRefreshWorker")
    GenServer.start_link(__MODULE__, config, name: __MODULE__)
  end

  def init(map) do
    Logger.debug("Initializing #{__MODULE__} with config: #{inspect(map)}")

    state = %{
      client: Client.new_client(map),
      config: map
    }

    {:ok, state}
  end

  def get_client() do
    GenServer.call(__MODULE__, :get_client, 30_000)
  end

  def handle_call(:get_client, _from, state) do
    {:reply, state.client, state}
  end
end
