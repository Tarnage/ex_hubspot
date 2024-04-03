defmodule Hubspot.Deals do
  @deals_url_v3 "/crm/v3/objects/deals/"

  @properties_schema [
    properties: [type: :map]
  ]

  @type properties() :: [unquote(NimbleOptions.option_typespec(@properties_schema))]

  # TODO: move these to config file
  @deal_properties "dealstage"
  @properties_jo1 "num_openings_jo1,custom_text13_jo1,custom_text_block5_jo1,custom_text2_jo1,title_jo1,salary_jo1,category_id_jo1,custom_text12_jo1,custom_text11_jo1,address_jo1,custom_text15_jo1,start_date_jo1,correlated_custom_text2_jo1,description_jo1,employment_type_jo1,status"
  @properties_jo2 "num_openings_jo2,custom_text13_jo2,custom_text_block5_jo2,custom_text2_jo2,title_jo2,salary_jo2,category_id_jo2,custom_text12_jo2,custom_text11_jo2,address_jo2,custom_text15_jo2,start_date_jo2,correlated_custom_text2_jo2,description_jo2,employment_type_jo2,status_jo2"
  @properties_jo3 "num_openings_jo3,custom_text13_jo3,custom_text_block5_jo3,custom_text2_jo3,title_jo3,salary_jo3,category_id_jo3,custom_text12_jo3,custom_text11_jo3,address_jo3,custom_text15_jo3,start_date_jo3,correlated_custom_text2_jo3,description_jo3,employment_type_jo3,status_jo3"
  @properties_jo4 "num_openings_jo4,custom_text13_jo4,custom_text_block5_jo4,custom_text2_jo4,title_jo4,salary_jo4,category_id_jo4,custom_text12_jo4,custom_text11_jo4,address_jo4,custom_text15_jo4,start_date_jo4,correlated_custom_text2_jo4,description_jo4,employment_type_jo4,status_jo4"

  # @closed_won_intern_value "115505781"

  # @keys_to_remove ["createdate", "dealstage", "hsObjectId", "hsLastmodifieddate", "categoryID"]
  @spec get_deal_by_id(Hubspot.Client.t(), integer) ::
          {:ok, Req.Request.t()} | {:error, Mint.HTTPError.t()}
  def get_deal_by_id(client, deal_id) when is_integer(deal_id) do
    endpoint = client.options.base_url <> @deals_url_v3 <> "#{deal_id}"

    response =
      client
      |> Req.get(
        url: endpoint,
        params: %{
          properties:
            @deal_properties <>
              "," <>
              @properties_jo1 <>
              "," <> @properties_jo2 <> "," <> @properties_jo3 <> "," <> @properties_jo4
        }
      )

    response
  end

  def get_deal_by_id(_client, deal_id) do
    {:error, "Invalid deal id: #{deal_id}"}
  end

  @doc """
  Updates a Deal object in Hubspot

  ## Parameters
    - `client` - The client to use for the request
    - `deal_id` - The id of the deal to update
    - `deal_params` - #{NimbleOptions.docs(@properties_schema)}
  """
  @spec update_deal(Hubspot.Client.t(), integer, properties()) ::
          {:ok, Req.Request.t()} | {:error, Mint.HTTPError.t()}
  def update_deal(client, deal_id, deal_params) do
    endpoint = client.options.base_url <> @deals_url_v3 <> "#{deal_id}"
    response = client |> Req.patch(url: endpoint, body: deal_params)
    response
  end

  # def update_deal(client, deal_id) do
  # end
end
