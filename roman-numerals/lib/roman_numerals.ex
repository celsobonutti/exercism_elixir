defmodule RomanNumerals do
  @table [
    [{:arabic, 1000}, {:roman, "M"}],
    [{:arabic, 900}, {:roman, "CM"}],
    [{:arabic, 500}, {:roman, "D"}],
    [{:arabic, 400}, {:roman, "CD"}],
    [{:arabic, 100}, {:roman, "C"}],
    [{:arabic, 90}, {:roman, "XC"}],
    [{:arabic, 50}, {:roman, "L"}],
    [{:arabic, 40}, {:roman, "XL"}],
    [{:arabic, 10}, {:roman, "X"}],
    [{:arabic, 9}, {:roman, "IX"}],
    [{:arabic, 5}, {:roman, "V"}],
    [{:arabic, 4}, {:roman, "IV"}],
    [{:arabic, 1}, {:roman, "I"}]
  ]

  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    case Enum.find(@table, fn element -> number >= element[:arabic] end) do
      [{:arabic, arabic}, {:roman, roman}] -> roman <> numeral(number - arabic)
      nil -> ""
    end
  end
end
