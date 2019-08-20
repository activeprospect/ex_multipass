defmodule MultipassEx.CodingTest do
  @moduledoc false
  use ExUnit.Case
  use ExUnitProperties

  import MultipassEx.TestData

  alias MultipassEx.Coding

  property "encode/1 returns mutated string with values replaced" do
    check all string <- pseudo_encrypted_string() do
      url_safe = Coding.encode(string)

      refute String.contains?(url_safe, "+")
      refute String.contains?(url_safe, "\n")
      refute String.contains?(url_safe, "/")
    end
  end

  property "decode/1 returns encoded string with mutations removed" do
    check all string <- pseudo_encrypted_string() do
      url_safe = Coding.encode(string)
      assert {:ok, ^string} = Coding.decode(url_safe)
    end
  end

  property "decode/1 trims trailing equals" do
    check all string <- pseudo_encrypted_string(),
              equals <- random_equals() do
      url_safe = Coding.encode(string)
      assert {:ok, ^string} = Coding.decode(url_safe <> equals)
    end
  end
end
