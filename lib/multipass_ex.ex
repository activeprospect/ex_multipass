defmodule MultipassEx do
  @moduledoc """
  Support for consuming and generating Multipass payloads based on the Rails
  gem `Multipass`.

  If integrating with a service using the Rails gem care must be taken to ensure
  `site_key` and `api_key` match between the services.

  ## Example

      iex> MultipassEx.encode(%{example: "data"}, "my_site_key", "my_super_secret_key_shh")
      {:ok, "HFtLULqnAfVZexe46_T5KHJcgSRwAtf45zPwJ5g361w"}

      iex> MultipassEx.decode("HFtLULqnAfVZexe46_T5KHJcgSRwAtf45zPwJ5g361w", "my_site_key", "my_super_secret_key_shh")
      {:ok, %{"example" => "data"}}
  """

  alias MultipassEx.{Crypto, CryptoError, DecodingError, EncodingError, JSONDecodingError}

  @doc """
  Encodes a map resulting in a Multipass compliant string.
  """
  @spec encode(map(), String.t(), String.t()) ::
          {:ok, String.t()}
          | {:error, EncodingError.t()}
  defdelegate encode(data, site_key, api_key), to: Crypto, as: :encrypt

  @doc """
  Decodes a Multipass string into a map.
  """
  @spec decode(String.t(), String.t(), String.t()) ::
          {:ok, map()} | {:error, DecodingError.t() | CryptoError.t() | JSONDecodingError.t()}
  defdelegate decode(data, site_key, api_key), to: Crypto, as: :decrypt
end
