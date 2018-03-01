defmodule MultipassExTest do
  use ExUnit.Case
  use ExUnitProperties
  doctest MultipassEx

  property "encoding and decoding" do
    check all map <-
                fixed_map(%{
                  "idk" =>
                    fixed_map(%{
                      "needed" => string(:alphanumeric),
                      "strings" => string(:alphanumeric),
                      "for" => string(:alphanumeric),
                      "this" => string(:alphanumeric),
                      "to" => string(:alphanumeric),
                      "test" => boolean(),
                      "somewhat" => string(:alphanumeric)
                    }),
                  "complex" => list_of(fixed_map(%{})),
                  "structure" => string(:alphanumeric),
                  "with" =>
                    list_of(
                      fixed_map(%{
                        "a" => string(:alphanumeric),
                        "round" => string(:alphanumeric),
                        "trip" => string(:alphanumeric),
                        "of" => boolean()
                      })
                    ),
                  "this" => string(:alphanumeric),
                  "." => boolean()
                }),
              site_key <- string(:alphanumeric),
              secret <- string(:alphanumeric) do
      assert map ==
               map
               |> MultipassEx.encode!(site_key, secret)
               |> MultipassEx.decode!(site_key, secret)
    end
  end

  property "padding and unpadding roundtrip equivalence" do
    check all data <- string(:alphanumeric),
              block_size <- positive_integer() do
      assert data == data |> MultipassEx.pad(block_size) |> MultipassEx.unpad()
    end
  end
end
