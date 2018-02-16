defmodule MultipassEx do
  @moduledoc """
  Mimicking ruby multipass default encryption of aes_cbc128
  """
  @aes128_block_size 16
  @encryption_bits   128
  @iv                String.duplicate(<<0>>, 16)

  @spec gen_encode(String.t, String.t) :: (String.t -> String.t)
  def gen_encode(site_key, api_key) do
    fn(data) ->
      formatted_data = data
        |> Jason.encode!()
        |> pad(@aes128_block_size)

      :crypto.block_encrypt(:aes_cbc128, generate_key(site_key, api_key), @iv, formatted_data)
        |> Base.url_encode64()
    end
  end

  @spec gen_decode(String.t, String.t) :: (String.t -> map())
  def gen_decode(site_key, api_key) do
    fn(data) ->
      formatted_data = Base.url_decode64!(data)

      :crypto.block_decrypt(:aes_cbc128, generate_key(site_key, api_key), @iv, formatted_data)
        |> unpad()
        |> Jason.decode!()
    end
  end

  @spec generate_key(String.t, String.t) :: binary()
  defp generate_key(password, salt) do
    :crypto.hash(:sha, salt <> password) |> truncate_secret()
  end

  @spec truncate_secret(String.t) :: String.t
  defp truncate_secret(secret) do
    << key::size(@encryption_bits), _rest::binary>> = secret
    << key::size(@encryption_bits) >>
  end

  @spec pad(String.t, pos_integer()) :: String.t
  def pad(data, block_size) do
    to_add = block_size - rem(byte_size(data), block_size)
    data <> :binary.copy(<< to_add >>, to_add)
  end

  @spec unpad(binary()) :: binary()
  def unpad(data) do
    to_remove = :binary.last(data)
    :binary.part(data, 0, byte_size(data) - to_remove)
  end

end
