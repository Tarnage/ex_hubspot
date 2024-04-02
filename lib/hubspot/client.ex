defmodule Hubspot.Client do
  defstruct [:rest_url, :hs_access_token, :retry]

  @type client_config :: %__MODULE__{
          rest_url: String.t(),
          hs_access_token: String.t(),
          retry: boolean()
        }

  @spec new_client(client_config) :: Req.Request.t()
  def new_client(%{
        rest_url: rest_url,
        hs_access_token: hs_access_token,
        retry: retry
      }) do
    Req.new(base_url: rest_url, retry: retry)
    |> Req.Request.put_header("authorization", "Bearer #{hs_access_token}")
    |> Req.Request.put_header("accept", "application/json")
    |> Req.Request.put_header("content-type", "application/json")
  end
end
