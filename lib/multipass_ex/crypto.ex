defmodule MultipassEx.Crypto do
  @moduledoc false

  # Module for encrypting and decrypting data in compliance with the Ruby MultiPass
  # gem.
  #
  # AES_CBC128 is the encryption algorithm used.
  #
  # __Warning__: The ruby gem uses an insecure IV and it's mirrored here to be compatible
  # since it is not sent with the Multipass data.

  require Logger

  alias MultipassEx.{Coding, CryptoError, DecodingError, EncodingError, JSONDecodingError}

  @algorithm :aes_cbc128
  @block_size 16
  @key_byte_length 16
  @iv String.duplicate(<<0>>, 16)

  @spec encrypt(map(), binary(), binary()) ::
          {:ok, String.t()}
          | {:error, EncodingError.t()}
  def encrypt(data, site_key, api_key) when is_map(data) do
    key = generate_key(site_key, api_key)

    case prepare_data_for_encryption(data) do
      {:ok, prepared_data} ->
        encrypted_data =
          @algorithm
          |> :crypto.block_encrypt(key, @iv, prepared_data)
          |> Coding.encode()

        {:ok, encrypted_data}

      {:error, error_struct} ->
        {:error, error_struct}
    end
  end

  @spec decrypt(String.t(), binary(), binary()) ::
          {:ok, map()} | {:error, CryptoError.t() | DecodingError.t() | JSONDecodingError.t()}
  def decrypt(data, site_key, api_key) do
    case Coding.decode(data) do
      {:ok, decoded_data} ->
        decrypt_or_error(decoded_data, site_key, api_key)

      {:error, error} ->
        {:error, error}
    end
  end

  @spec decrypt_or_error(binary(), binary(), binary()) ::
          {:ok, map()} | {:error, CryptoError.t() | DecodingError.t()}
  defp decrypt_or_error(data, site_key, api_key) do
    key = generate_key(site_key, api_key)

    @algorithm
    |> :crypto.block_decrypt(key, @iv, data)
    |> process_decrypted_data()
    |> case do
      {:ok, data} -> {:ok, data}
      {:error, error_struct} -> {:error, error_struct}
    end
  rescue
    ArgumentError ->
      {:error, %CryptoError{message: "decryption failed", reason: :argument_error}}
  end

  @spec process_decrypted_data(binary()) :: {:ok, map()} | {:error, JSONDecodingError.t()}
  defp process_decrypted_data(data) do
    data
    |> unpad()
    |> Jason.decode()
    |> case do
      {:ok, json} ->
        {:ok, json}

      {:error, _exception} ->
        {:error,
         %JSONDecodingError{
           message: "json decoding failed",
           reason: :json_decoding_error,
           data: data
         }}
    end
  end

  @spec prepare_data_for_encryption(map()) :: {:ok, binary} | {:error, EncodingError.t()}
  defp prepare_data_for_encryption(data) do
    prepared_data =
      data
      |> Jason.encode!()
      |> pad()

    {:ok, prepared_data}
  rescue
    Jason.EncodeError ->
      {:error,
       %EncodingError{
         message: "json encoding failed",
         reason: :json_encoding_error
       }}
  end

  @spec generate_key(String.t(), String.t()) :: binary()
  defp generate_key(password, salt) do
    :crypto.hash(:sha, salt <> password) |> truncate_secret()
  end

  # typespec: capture a binary followed by a bitstring and return 128 bits (@key_byte_length)
  # credo:disable-for-next-line
  @spec truncate_secret(<<_::8, _::_*1>>) :: <<_::128>>
  defp truncate_secret(<<key::binary-size(@key_byte_length), _rest::bitstring>>) do
    key
  end

  @spec pad(String.t()) :: binary()
  defp pad(data) when is_binary(data) do
    to_add = @block_size - rem(byte_size(data), @block_size)
    data <> :binary.copy(<<to_add>>, to_add)
  end

  @spec unpad(binary()) :: binary()
  defp unpad(data) when is_binary(data) do
    to_remove = :binary.last(data)
    :binary.part(data, 0, byte_size(data) - to_remove)
  end
end
