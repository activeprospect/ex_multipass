# ExMultipass
[![Build Status](https://travis-ci.com/activeprospect/ex_multipass.svg?branch=master)](https://travis-ci.com/activeprospect/ex_multipass)
[![Coverage Status](https://coveralls.io/repos/github/activeprospect/ex_multipass/badge.svg?branch=master)](https://coveralls.io/github/activeprospect/ex_multipass?branch=master)

**Ruby compatible multipass encryption and decryption**

![Multipass](https://media.giphy.com/media/lKPFZ1nPKW8c8/giphy-downsized.gif)

## Installation

The package can be installed by adding `ex_multipass` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_multipass, "~> 0.3"}
  ]
end
```

- Call `ExMultipass.encode(map_to_encode, site_key, secret)` to encode a multipass and
- `ExMultipass.decode(encoded_multipass, site_key, secret)` to decrypt a multipass

The docs can be found at [https://hexdocs.pm/ex_multipass](https://hexdocs.pm/ex_multipass).

