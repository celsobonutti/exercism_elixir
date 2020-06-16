defmodule Bob do
  def hey(input) do
    cond do
      empty?(input) ->
        "Fine. Be that way!"

      question?(input) && yelling?(input) ->
        "Calm down, I know what I'm doing!"

      question?(input) ->
        "Sure."

      yelling?(input) ->
        "Whoa, chill out!"

      true ->
        "Whatever."
    end
  end

  def question?(input) do
    input
    |> String.trim()
    |> String.last() ==
      "?"
  end

  def yelling?(input) do
    String.match?(input, ~r/[[:alpha:]]/) && input === String.upcase(input)
  end

  @spec empty?(binary) :: boolean
  def empty?(input) do
    input
    |> String.trim() ===
      ""
  end
end
