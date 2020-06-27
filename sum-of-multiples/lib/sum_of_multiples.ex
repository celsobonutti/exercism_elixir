defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    1..(limit - 1)
    |> Enum.reduce(0, fn element, acc ->
      if Enum.any?(factors, fn factor -> rem(element, factor) == 0 end) do
        acc + element
      else
        acc
      end
    end)
  end
end
