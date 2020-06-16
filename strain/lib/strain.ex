defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def keep(list, fun) do
    list
    |> filter(fun)
  end

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def discard(list, fun) do
    list
    |> filter(fn el -> !fun.(el) end)
  end

  @spec filter(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def filter(list, fun) do
    list
    |> List.foldr([], fn el, acc ->
      case fun.(el) do
        true -> [el | acc]
        false -> acc
      end
    end)
  end
end
