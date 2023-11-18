defmodule ExHubspot.Client do
  defstruct [:hs_api_endpoint, :api_token]

  @type client_config :: %__MODULE__{
          hs_api_endpoint: String.t(),
          api_token: String.t()
        }

  def new(%{hs_api_endpoint: endpoint, api_token: api_token}) do
    base_url = String.replace_trailing(endpoint, "/", "")
  end
end
