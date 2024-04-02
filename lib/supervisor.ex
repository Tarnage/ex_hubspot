defmodule Hubspot.ClientSupervisor do
  alias Hubspot.OauthRefreshWorker
  use Supervisor

  def start_link(args, _opts \\ []) do
    Supervisor.start_link(__MODULE__, args, name: __MODULE__)
  end

  def init(args) do
    children = [{OauthRefreshWorker, args}]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
