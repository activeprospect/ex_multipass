defmodule MultipassEx.DecodingError do
  @moduledoc """
  Error handler for base64 decoding errors.
  """
  defexception [:message, :reason, :data]

  @type t :: %__MODULE__{
          message: String.t(),
          reason: atom(),
          data: String.t()
        }
end

defmodule MultipassEx.EncodingError do
  @moduledoc """
  Error handler for encoding errors such as base64.
  """
  defexception [:message, :reason]

  @type t :: %__MODULE__{
          message: String.t(),
          reason: atom()
        }
end

defmodule MultipassEx.CryptoError do
  @moduledoc """
  Error handler for encryption/decryption related errors.
  """
  defexception [:message, :reason]

  @type t :: %__MODULE__{
          message: String.t(),
          reason: atom()
        }
end

defmodule MultipassEx.JSONDecodingError do
  @moduledoc """
  Error handler for JSON decoding errors.
  """
  defexception [:message, :reason, :data]

  @type t :: %__MODULE__{
          message: String.t(),
          reason: atom(),
          data: String.t()
        }
end
