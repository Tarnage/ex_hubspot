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

  # def handle_continue(:tick, state) do
  #   Logger.debug("Handling tick")
  #   tick()
  #   {:noreply, state}
  # end

  # def handle_info(:tick, state) do
  #   tick()
  #   {:noreply, state}
  # end

  # def tick() do
  #   # Process.send_after instructs OTP to schedule a message to be sent to the current process after a given delay.
  #   Process.send_after(self(), :tick, 0)
  # end
end
