defmodule MultipassEx.Coding do
  @moduledoc false

  # Encoding / Decoding of Multipass data.
  #
  # The MultipassEx gem truncates padding characters from base64 encoding whether
  # they are present or not. It then adds a single padding character to the end
  # of the base64 encoded string before decoding without reguard to its necessity.
  # This causes issues if you decode without `padding: false` as it causes padding
  # errors. Encoding should also be done without padding.
  #
  # The gem also replaces characters after base64 encoding to make the string
  # "url safe". This happens before base64 decoding and after base64 encoding.

  alias MultipassEx.DecodingError

  @doc """
  Base64 encode the string without padding and replace characters to match the
  ruby gems "url_safe" flag.
  """
  @spec encode(binary) :: String.t()
  def encode(data) do
    data
    |> Base.encode64(padding: false)
    |> String.replace("+", "-", global: true)
    |> String.replace("/", "_", global: true)
    |> String.replace("\n", "", global: true)
  end

  @doc """
  Base64 decode the string without padding. Any trailing padding characters `=`
  are removed because we cannot determine if the string is padded correctly and
  leaving them in place causes errors when decoding with `padding: false`. Also
  replace characters to match the ruby gems "url_safe" flag.
  """
  @spec decode(String.t()) :: {:ok, binary} | {:error, DecodingError.t()}
  def decode(data) do
    data
    |> String.replace("-", "+", global: true)
    |> String.replace("_", "/", global: true)
    |> String.trim_trailing("=")
    |> Base.decode64(padding: false)
    |> case do
      {:ok, decoded_binary} ->
        {:ok, decoded_binary}

      :error ->
        {:error,
         %DecodingError{
           message: "base64 decoding failed",
           reason: :base64_decoding_error,
           data: data
         }}
    end
  end
end
