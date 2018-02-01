defmodule LandingPage.Marketing do
  @moduledoc """
  The Marketing context.
  """

  import Ecto.Query, warn: false
  alias LandingPage.Repo

  alias LandingPage.Marketing.Lead
  alias LandingPage.Clients.GoogleRecaptchaHttp

  @google_recaptcha_client Application.get_env(:landing_page, :google_recaptcha)[:client]

  @doc """
  Returns the list of leads.

  ## Examples

      iex> list_leads()
      [%Lead{}, ...]

  """
  def list_leads do
    Repo.all(Lead)
  end

  @doc """
  Gets a single lead.

  Raises `Ecto.NoResultsError` if the Lead does not exist.

  ## Examples

      iex> get_lead!(123)
      %Lead{}

      iex> get_lead!(456)
      ** (Ecto.NoResultsError)

  """
  def get_lead!(id), do: Repo.get!(Lead, id)

  @doc """
  Creates a lead.

  ## Examples

      iex> create_lead(%{field: value})
      {:ok, %Lead{}}

      iex> create_lead(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_lead(attrs \\ %{}) do
    %Lead{}
    |> Lead.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a lead.

  ## Examples

      iex> update_lead(lead, %{field: new_value})
      {:ok, %Lead{}}

      iex> update_lead(lead, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_lead(%Lead{} = lead, attrs) do
    lead
    |> Lead.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Lead.

  ## Examples

      iex> delete_lead(lead)
      {:ok, %Lead{}}

      iex> delete_lead(lead)
      {:error, %Ecto.Changeset{}}

  """
  def delete_lead(%Lead{} = lead) do
    Repo.delete(lead)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking lead changes.

  ## Examples

      iex> change_lead(lead)
      %Ecto.Changeset{source: %Lead{}}

  """
  def change_lead(%Lead{} = lead) do
    Lead.changeset(lead, %{})
  end

  def subscribe(lead_params) do
    token = Map.get(lead_params, "recaptcha_token")

    with %Ecto.Changeset{valid?: true} = changeset <- Lead.changeset(%Lead{}, lead_params),
         {:ok, %{success: true}} <- @google_recaptcha_client.verify(token),
         {:ok, lead} <- Repo.insert(changeset) do
      {:ok, lead}
    else
      {:ok, %{success: false}} -> {:error, :invalid_recaptcha_token}

      {:error, response} -> {:error, response}

      other -> {:error, other}
    end
  end
end
