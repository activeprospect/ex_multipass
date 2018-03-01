# MultipassEx

**Ruby compatible multipass encryption and decryption**

## Installation

The package can be installed by adding `multipass_ex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:multipass_ex, "~> 0.1.0"}
  ]
end
```

- Call `MultipassEx.encode!(map_to_encode, site_key, secret)` to encode a multipass and
- `MultipassEx.decode!(encoded_multipass, site_key, secret)` to decrypt a multipass

The docs can be found at [https://hexdocs.pm/multipass_ex](https://hexdocs.pm/multipass_ex).

