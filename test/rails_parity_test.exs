defmodule MultipassEx.RailsParityTest do
  @moduledoc false
  use ExUnit.Case

  import MultipassEx.TestFixtures

  test "decode/3 returns the expected map when decoding a string from the Ruby Multipass gem" do
    api_key = "ZbQ257@I0tGfTl@c5uij4Tz3O^3^ThJi"
    site_key = "t9M*$XoV1zx0&qmDrSu&Fc9j@lla3U50"

    {:ok, multipass_ex_decode} = MultipassEx.decode(rails_encrypted_string(), site_key, api_key)

    assert multipass_ex_decode == rails_expected_map()
  end
end
