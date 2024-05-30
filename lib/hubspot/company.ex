defmodule Hubspot.Company do
  @moduledoc """
  This module is responsible for managing companies in Hubspot CRM.
  """

  # Public API functions

  # Retrieves a company by ID
  @spec get_company(Req.Request.t(), String.t()) :: {:ok, map()} | {:error, map()}
  def get_company(client, id) do
    client
    |> Req.get(url: "/crm/v3/objects/companies/#{id}")
    |> handle_response()
  end

  # Creates a new company
  @spec create_company(Req.Request.t(), map()) :: {:ok, map()} | {:error, map()}
  def create_company(client, properties) do
    client
    |> Req.post(url: "/crm/v3/objects/companies", json: properties)
    |> handle_response()
  end

  # Updates an existing company
  @spec update_company(Req.Request.t(), String.t(), map()) :: {:ok, map()} | {:error, map()}
  def update_company(client, id, properties) do
    client
    |> Req.put(url: "/crm/v3/objects/companies/#{id}", json: properties)
    |> handle_response()
  end

  # Deletes a company by ID
  @spec delete_company(Req.Request.t(), String.t()) :: {:ok, map()} | {:error, map()}
  def delete_company(client, id) do
    client
    |> Req.delete(url: "/crm/v3/objects/companies/#{id}")
    |> handle_response()
  end

  # Private helper functions

  defp handle_response({:ok, %{status: 200, body: body}}), do: {:ok, body}

  defp handle_response({:ok, %{status: status, body: body}}) when status in 400..599,
    do: {:error, body}

  defp handle_response({:error, reason}), do: {:error, reason}
end
