defmodule MultipassEx.TestData do
  @moduledoc false
  use ExUnitProperties

  @dialyzer :no_return

  def site_key do
    string(:alphanumeric, min_length: 32)
  end

  def api_key do
    string(:alphanumeric, min_length: 32)
  end

  def example_structure do
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
    })
  end

  def pseudo_encrypted_string do
    string('abcdefghijklmnopqrstuvwxyz+\n/', min_length: 60)
  end

  def random_equals do
    gen all count <- integer(1..10),
            equals_string <- string('=', min_length: count) do
      equals_string
    end
  end
end
