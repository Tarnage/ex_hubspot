defmodule ExHubspot.Client do
  # require Logger

  # use GenServer
  # @me __MODULE__
  # defstruct [:hs_api_endpoint, :access_token, :hs_secret]

  # # @type config :: %__MODULE__{
  # #         hs_api_endpoint: String.t(),
  # #         access_token: String.t(),
  # #         hs_secret: String.t()
  # #       }

  # # API
  # def start_link(config) do
  #   config = sanitize_config(config)
  #   Logger.debug("Config received: #{inspect(config)}")

  #   for {k, v} <- config, is_nil(v) do
  #     raise "Missing :ex_hubspot config value for #{k} field"
  #   end

  #   Logger.debug("Starting Hubspot GenServer #{inspect(config)}")

  #   GenServer.start_link(@me, config, name: @me)
  # end

  # # Server Implementation
  # def init(config) do
  #   Logger.debug("Initializing #{__MODULE__} with config: #{inspect(config)}")
  #   {:ok, new(config)}
  # end

  def new(%{hs_api_endpoint: endpoint, access_token: access_token} = client) do
    base_url = String.replace_trailing(endpoint, "/", "")

    Req.new(base_url: base_url, retry: false)
    |> Req.Request.put_header("authorization", "Bearer #{access_token}")
    |> Req.Request.put_header("accept", "application/json")
    |> Req.Request.put_header("content-type", "application/json")
  end

  # Helper
  def sanitize_config(config) do
    Enum.into(config, %{}, fn {k, v} ->
      {k, String.trim(v)}
    end)
  end
end
