defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) do
    Regex.scan(~r/(.)\1*/u, string, capture: :first)
    |> Enum.reduce("", fn [group], text ->
      case String.length(group) do
        1 -> text <> group
        value -> text <> "#{value}#{String.at(group, 0)}"
      end
    end)
  end

  @spec decode(String.t()) :: String.t()
  def decode(string) do
    Regex.scan(~r/(\d*.{1})/u, string, capture: :first)
    |> Enum.reduce("", fn [word], acc ->
      if String.length(word) == 1 do
        acc <> word
      else
        {length, letter} = String.split_at(word, -1)
        length = String.to_integer(length)
        acc <> String.duplicate(letter, length)
      end
    end)
  end
end
