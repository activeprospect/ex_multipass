defmodule MultipassEx do
  @moduledoc """
  Mimicking ruby multipass default encryption of aes_cbc128
  """
  @aes128_block_size 16
  @encryption_bits   128
  @iv                <<0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>>

  @spec genEncode(String.t, String.t) :: (String.t -> String.t)
  def genEncode(site_key, api_key) do
    fn(data) ->
      formatted_data = data
        |> Poison.encode!()
        |> pad(@aes128_block_size)

      :crypto.block_encrypt(:aes_cbc128, generate_key(site_key, api_key), @iv, formatted_data)
        |> Base.url_encode64()
    end
  end

  @spec genDecode(String.t, String.t) :: (String.t -> map())
  def genDecode(site_key, api_key) do
    fn(data) ->
      formatted_data = data |> Base.url_decode64!()

      :crypto.block_decrypt(:aes_cbc128, generate_key(site_key, api_key), @iv, formatted_data)
        |> unpad()
        |> Poison.decode!()
    end
  end

  @spec generate_key(String.t, String.t) :: String.t
  defp generate_key(password, salt) do
    :crypto.hash(:sha, salt <> password) |> truncate_secret()
  end

  @spec truncate_secret(String.t) :: String.t
  defp truncate_secret(secret) do
    << key::size(@encryption_bits), _rest::binary>> = secret
    << key::size(@encryption_bits) >>
  end

  @spec pad(String.t, pos_integer()) :: String.t
  defp pad(data, block_size) do
    to_add = block_size - rem(byte_size(data), block_size)
    data <> to_string(:string.chars(to_add, to_add))
  end

  @spec unpad(binary()) :: binary()
  defp unpad(data) do
    to_remove = :binary.last(data)
    :binary.part(data, 0, byte_size(data) - to_remove)
  end

end
