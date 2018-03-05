defmodule MultipassEx do
  @moduledoc """
  Mimicking ruby multipass default encryption of aes_cbc128
  """
  @aes128_block_size 16
  @encryption_bits 128
  # this is from the ruby default OpenSSL IV and is insecure
  @iv String.duplicate(<<0>>, 16)

  @doc """
  Encodes a map into a multipass with a given site_key and api_key
  """
  @spec encode(map(), String.t(), String.t()) :: {:ok, String.t()} | {:error, any()}
  def encode(data, site_key, api_key)
      when is_map(data) and is_binary(site_key) and is_binary(api_key) do
    try do
      formatted_data =
        data
        |> Jason.encode!()
        |> pad(@aes128_block_size)

      encoded_data =
        :aes_cbc128
        |> :crypto.block_encrypt(generate_key(site_key, api_key), @iv, formatted_data)
        |> Base.url_encode64()

      {:ok, encoded_data}
    rescue
      err -> {:error, err}
    end
  end

  @doc """
  Decodes a given multipass into a map with a given site_key and api_key
  """
  @spec decode(String.t(), String.t(), String.t()) :: {:ok, map()} | {:error, String.t()}
  def decode(data, site_key, api_key)
      when is_binary(data) and is_binary(site_key) and is_binary(api_key) do
    try do
      formatted_data = Base.url_decode64!(data)

      decoded_data =
        :aes_cbc128
        |> :crypto.block_decrypt(generate_key(site_key, api_key), @iv, formatted_data)
        |> unpad()
        |> Jason.decode!()

      {:ok, decoded_data}
    rescue
      e in ArgumentError -> {:error, e.message}
    end
  end

  @spec generate_key(String.t(), String.t()) :: binary()
  defp generate_key(password, salt) do
    :crypto.hash(:sha, salt <> password) |> truncate_secret()
  end

  @spec truncate_secret(String.t()) :: String.t()
  defp truncate_secret(secret) do
    <<key::size(@encryption_bits), _rest::binary>> = secret
    <<key::size(@encryption_bits)>>
  end

  @doc false
  @spec pad(String.t(), pos_integer()) :: String.t()
  def pad(data, block_size) when is_binary(data) and is_integer(block_size) and block_size >= 0 do
    to_add = block_size - rem(byte_size(data), block_size)
    data <> :binary.copy(<<to_add>>, to_add)
  end

  @doc false
  @spec unpad(binary()) :: binary()
  def unpad(data) when is_binary(data) do
    to_remove = :binary.last(data)
    :binary.part(data, 0, byte_size(data) - to_remove)
  end
end
