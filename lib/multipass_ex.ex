defmodule MultipassEx do
  @moduledoc """
  Documentation for MultipassEx.
  """
  @aes128_block_size 16
  @encryption_bits   128
  @iv                :crypto.strong_rand_bytes(16)

  def pad(data, block_size) do
    to_add = block_size - rem(byte_size(data), block_size)
    data <> to_string(:string.chars(to_add, to_add))
  end

  def unpad(data) do
    to_remove = :binary.last(data)
    :binary.part(data, 0, byte_size(data) - to_remove)
  end

  def genEncode(site_key, api_key, options \\ []) do
    url_safe = Keyword.get(options, :url_safe, true)

    fn(data) ->
      formatted_data = data
        |> pad(@aes128_block_size)

      :crypto.block_encrypt(:aes_cbc128, generate_key(site_key, api_key), @iv, formatted_data)
    end
  end

  def genDecode(site_key, api_key, options \\ []) do
    url_safe = Keyword.get(options, :url_safe, true)

    fn(data) ->
      :crypto.block_decrypt(:aes_cbc128, generate_key(site_key, api_key), @iv, data)
        |> unpad()
    end
  end

  defp generate_key(password, salt) do
    :crypto.hash(:sha, salt <> password) |> truncate_secret()
  end

  defp truncate_secret(secret) do
    << key::size(@encryption_bits), _rest::binary>> = secret
    << key::size(@encryption_bits) >>
  end

end
