# ExMultipass
[![Build Status](https://travis-ci.com/activeprospect/multipass_ex.svg?branch=master)](https://travis-ci.com/activeprospect/multipass_ex)
[![Coverage Status](https://coveralls.io/repos/github/activeprospect/multipass_ex/badge.svg?branch=master)](https://coveralls.io/github/activeprospect/multipass_ex?branch=master)

**Ruby compatible multipass encryption and decryption**

![Multipass](https://media.giphy.com/media/lKPFZ1nPKW8c8/giphy-downsized.gif)

## Installation

The package can be installed by adding `multipass_ex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:multipass_ex, "~> 0.1"}
  ]
end
```

- Call `ExMultipass.encode(map_to_encode, site_key, secret)` to encode a multipass and
- `ExMultipass.decode(encoded_multipass, site_key, secret)` to decrypt a multipass

The docs can be found at [https://hexdocs.pm/multipass_ex](https://hexdocs.pm/multipass_ex).

