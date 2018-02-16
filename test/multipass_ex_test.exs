defmodule MultipassExTest do
  use ExUnit.Case
  use ExUnitProperties
  doctest MultipassEx

  test "Decodes a ruby sso generated multipass" do
    product_code = "trustedform"
    decode = MultipassEx.gen_decode(product_code,"b825369ddd76f42ed8a65e86de793e5be46fed39ee82be9dbefc141f01515d89311267b7d2085f48d3236de7a81fca97ae1669d2d08a3f6f9193edbfa5113117")

    ruby_multipass = "YmThUWzNGYRQSJMe5Jr4whCnyuMiXFljJTyiODUk2i5PUUDmhe0qdd1ra-5W1OJSSwTmSuSSMDELkNSWaYKzpwLRl6TwFavmA5nYUpuAIB-qjAHhz45jQP-N1yguTcLKpj2GX5hj3OBakYz8xAsgEVx6-Y73uIZzOfFdcEfKB3EPCSM5KE6zgv5uCvcHsRLxo0p63hr5-PHHmirWpBaOvvd8mJIMVBs9gl-83Z7WiDjXSQ8iN-j1vdtaDeis95HsxZLN2UuGEz2ImzSpY7Hs1ShFlQQK27p8ns020cWEYrXURkw6kATrnGwbIOhz3Es2Qa3LeKKjGOnPRDUKIDEJwEOpTQVSHh2pK1StAi6RtFKSGLAwCq9WrWAc2XqcMyVUUeFE4U82vYMErw6Qf6_l94whxW6H86GTw6w3JSmAzZ_P5ap3aXEeliOZedwcqkhAhGy-tvZlnFwEsF0X8A__zmre9nj6pTPfl29Bmwpr_akciXk91tVBEcD9zxGA-FlWp_WjSRnR0UVJ_iUsCrfJ_VRvOHcCCwv_FHqkFLMbqnZJpYrN62h6SATQWHHs8mUYL8CL-JLziQGwnTZi035s3mim6UiS8hwGcROVvh_NtAC6196DG8F6QyCbqXhs4MmT7pJ2O2Q9uWHHLXvB07VTqW6CVzoZXNFCUH953t9QXn3naWXNJ_29R3NuHvxn0fKPiNiFNWJvdpzQhW1qj1p1zHNxcm_wtKeQ2HVa3lHn_gXDv7NDoBhXH0gqwk_2xcepXSNpm7B5nFRO2lM0iRH-5XVk3p5OsOzQ-rFIaLnaabKrQBATWrQhGbrERxq1XM9SvP21bjLbjT60c-um7ysjDI8ey4R8VTv-RB720r6XaQ4hEmedojdKWTLD8Mb16azwfZvKiNyogLPM1edmlSSCqUSqrAZwknnyRmsuVGfoSHyLpSySXkx_vttqY0zhOMylx9MR_TH7JtIZ5Voq-QAI-N05ocilJCNQAIziFveJyh5PCIZIi-RA-ySPWS53pJnrV-GCayMjs4k8XInahpK1zDayFKcpJWw9g3RpBHoNieQpz8hj0_P2zCN3sNk49vFYYhmkKL2xphZuMeDVec7lI4AADahTcthKM0NEWw4_yb55GW_2QSS1Lq0qmVaiGfuY_AhqlpD_DNTgp3bT1dr5E8kMzpHjqgJDpmpE1gqDAid7k9nmRZbgIWP_kmoftLYyfe_XZbrEs33r059I8SlTqCooDEm8gh0Nnjl7WqfEPEcGUoVVKWn_gCSLwNipQ6hVP57I8440o-pAYbf-WF6fPfTirPAoF2_AKotmkqLEBX4sfaWwbQxqVd5jwYRoDeAK1vRvX6FW7Ynu7gw2cOKYszsDH53C4gPhUU3SM0XGvbPRrRsMUo8XRHBd079SjzbsHnIOXiDj3QBegLPNpXJ3yeV5kO3HATSlwj7bgxHyH7usVFTRWs1X8R4CJx6wugchSkB-NQd9GMjzPTqgIAbGeUSZC0E09cmVZm5aZ_LPr-YfHXuFiKEzT9EBodmWnCDZyCPKg1v8ttdrwtkzKhFyZNcVvQnU_TYcR7a20Z_LfB9S1vAX9P0_cnV-huicy_yWrtJWTivurW2yI5NFqDIDfKWCPG7_sx7IxoYnLzohENdgJ9W9hXUA3ijAV5zrctK7WRojeR2LWhtVLr5e4fLXZuN8K8ifVikcyNETtyl_PnuCkn4MVWUwWtPtPECRNBi_F9RPYqntzs_WunOhtg162hbo6N7IjHXGNIVGlUN21hZnlYsyc1M0-i0aPh9Nc7lSsOrFLf1zH-jiN0non2YFaXj-zcdS-lRfPma6RJdSqnk-CXXw6-ftY_iG5xbA7FsLFq1nf7V-LYOEgyMYRUN9VgbhYCXUcHGnCVrgG0mfYWwD5eq6GLaBLn26pOh6OvcXcUWZhBRUApRJM8VH82U0XdF0-fioxbI6PX3L5ZQZp4AyjcGdKsSHQaFJyTdivUv_Xw1eQJmJLvtdYScVDy3umnrGomywWCA1NNo-u9YD8MSzidXGj1JIjvST94x5nwAP12kfj4UalWjR85qIm2fq9IoxuDdPrhacydvgAnhfmZTAx4aK2PYnZo5uD2wpzSeLTKRYY_-RGsfmpoZM4ZKkHK3PM1EHqf1Je8WsQxcMX7TB4CVSkyOOXSNCg74oBp5LGkVkf6PwhPQYt9TJCncixbQjuaBAOm7B7ISU2x54K7G2BT9__K41PUbhRfCNFpKIJA2lXWfIuJMn7X8bMhwlfFYeI6El4E_jmU8XlEmbG7P7RJQ7Ssb1K4dZR1dOWGa3"

    decoded_multipass = ruby_multipass |> decode.()

    assert decoded_multipass["product_code"] === product_code
  end

  test "can encode and decode a multipass map" do
    multi_pass_map = %{
      "account" => %{
        "api_key" => "9lcddd101328780kf0982657ef3132cb",
        "cancelled_at" => nil,
        "coupon_code" => "",
        "current_period_ends_at" => "2018-02-28T23:59:59.000-06:00",
        "current_period_started_at" => "2018-02-01T00:00:00.000-06:00",
        "enterprise" => false,
        "id" => "za7dfd630f78421c9585f889",
        "keen_project_id" => "5a7dfd66c9e77c00018ec154",
        "keen_read_api_key" => "F84326B73746CA(^&A&CDS&(SA&(6D6871FC910068C06A9DB87D25F463798FA2F444A6D74967BE9D51E94E08F440704B950ACDE12A2E0835AE76F810BD08DB9F1EB0E49835D5A7D0B7D088B2CD4E399F33885532A36A2D8B4F1C644214F8055E8197",
        "keen_write_api_key" => "652E04593971663673266328673287A341436CCA393379A1E20FC185BEF598C348A248E7672E6D9CC3BE0D51FB5AD15C668F7B045D0CD509054C334065D77AA2F02B5159EB8A047135128C0A6BC475CC3FB9570C34D14CBD7404F33",
        "marketing_reference" => "search",
        "name" => "fake inc",
        "subscription_id" => "5a7dzd640f78421c9585f894",
        "time_zone" => "Central Time (US & Canada)"
      },
      "accounts" => [],
      "api_key" => "1226a708085c31e7eee8e4243592225f",
      "company_name" => "fake inc",
      "component_pricing" => nil,
      "email" => "blah.fake@gmail.com",
      "expires" => "2018-02-16 17:12:14 UTC",
      "first_name" => "john",
      "id" => "1a7dfd600f78421c9585f889",
      "last_name" => "doe",
      "phone" => "",
      "product_code" => "fake",
      "products" => [
        %{
          "base_url" => "http://idk.test",
          "id" => "idk",
          "marketing_url" => "http://www.idk.test",
          "name" => "Idk",
          "subscribed" => true
        },
        %{
          "base_url" => "http://faker.test",
          "id" => "faker",
          "marketing_url" => "http://www.faker.test",
          "name" => "SuppressionList",
          "subscribed" => true
        },
        %{
          "base_url" => "http://fake.localhost",
          "id" => "fake",
          "marketing_url" => "http://www.fake.localhost",
          "name" => "Fake",
          "subscribed" => true
        }
      ],
      "role_string" => "user",
      "subscription_admin" => true,
      "superuser" => false,
      "user_admin" => true
    }

    product_code = "trustedform"
    secret       = "a895366zvc76f49ec8a65e86ce769e5ae46fec96ee89ae6caefc141f01515v86911967b7v9085f48v2236ze7a81fca97ae1664d2d08a3f6f9193edbfa5113127"

    encode = MultipassEx.gen_encode(product_code, secret)
    decode = MultipassEx.gen_decode(product_code, secret)
    encoded_map = multi_pass_map |> encode.() |> decode.()

    assert multi_pass_map === encoded_map
  end

  property "encoding and decoding" do
    check all map          <- fixed_map(%{
                                  "account" => fixed_map(%{
                                    "api_key" => string(:alphanumeric),
                                    "cancelled_at" => string(:alphanumeric),
                                    "coupon_code" => string(:alphanumeric),
                                    "current_period_ends_at" => string(:alphanumeric),
                                    "current_period_started_at" => string(:alphanumeric),
                                    "enterprise" => boolean(),
                                    "id" => string(:alphanumeric),
                                    "keen_project_id" => string(:alphanumeric),
                                    "keen_read_api_key" => string(:alphanumeric),
                                    "keen_write_api_key" => string(:alphanumeric),
                                    "marketing_reference" => string(:alphanumeric),
                                    "name" => string(:alphanumeric),
                                    "subscription_id" => string(:alphanumeric),
                                    "time_zone" => string(:alphanumeric)
                                  }),
                                  "accounts" => list_of(
                                    fixed_map(%{})
                                  ),
                                  "api_key" => string(:alphanumeric),
                                  "company_name" => string(:alphanumeric),
                                  "component_pricing" => string(:alphanumeric),
                                  "email" => string(:alphanumeric),
                                  "expires" => string(:alphanumeric),
                                  "first_name" => string(:alphanumeric),
                                  "id" => string(:alphanumeric),
                                  "last_name" => string(:alphanumeric),
                                  "phone" => string(:alphanumeric),
                                  "product_code" => string(:alphanumeric),
                                  "products" => list_of(
                                    fixed_map(%{
                                      "base_url" => string(:alphanumeric),
                                      "id" => string(:alphanumeric),
                                      "marketing_url" => string(:alphanumeric),
                                      "name" => string(:alphanumeric),
                                      "subscribed" => boolean()
                                    })
                                  ),
                                  "role_string" => string(:alphanumeric),
                                  "subscription_admin" => boolean(),
                                  "superuser" => boolean(),
                                  "user_admin" => boolean()}),
              product_code <- string(:alphanumeric),
              secret       <- string(:alphanumeric)
    do
      encode = MultipassEx.gen_encode(product_code, secret)
      decode = MultipassEx.gen_decode(product_code, secret)

      assert map == map |> encode.() |> decode.()
    end
  end
end
