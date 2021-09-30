defmodule ExMultipassTest do
  use ExUnit.Case
  use ExUnitProperties

  import ExMultipass.TestData

  alias ExMultipass.{CryptoError, DecodingError, JSONDecodingError}

  doctest ExMultipass

  property "encoding and decoding" do
    check all(
            data <- unshrinkable(example_structure()),
            site_key <- site_key(),
            api_key <- api_key(),
            max_runs: 20
          ) do
      {:ok, encrypted_data} = ExMultipass.encode(data, site_key, api_key)

      {:ok, decrypted_data} = ExMultipass.decode(encrypted_data, site_key, api_key)

      assert decrypted_data == data
    end
  end

  property "encoding and decoding with an invalid secret" do
    check all(
            map <- example_structure(),
            site_key <- site_key(),
            api_key <- api_key(),
            api_key_2 <- api_key(),
            max_runs: 20
          ) do
      {:ok, encrypted_data} = ExMultipass.encode(map, site_key, api_key)

      {:error, e} = ExMultipass.decode(encrypted_data, site_key, api_key_2)

      case e do
        %JSONDecodingError{} -> assert true
        %CryptoError{} -> assert true
        _ -> assert false
      end
    end
  end

  test "decode returns an base64 error on non-alphanumeric input" do
    assert ExMultipass.decode("$@$$", "123", "123") ===
             {:error,
              %DecodingError{
                reason: :base64_decoding_error,
                message: "base64 decoding failed",
                data: "$@$$"
              }}
  end

  test "decode returns an error on invalid data" do
    assert ExMultipass.decode("abc", "123", "123") ===
             {:error, %CryptoError{reason: :argument_error, message: "decryption failed"}}
  end
end
