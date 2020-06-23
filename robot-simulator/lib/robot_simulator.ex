defmodule RobotSimulator do
  @type direction ::
          :north
          | :east
          | :south
          | :west

  @directions [:north, :east, :south, :west]

  @direction_map [
    {:north, :east},
    {:east, :south},
    {:south, :west},
    {:west, :north}
  ]

  @moduledoc """
  Defines the Robot struct.
  Its direction consists of a `direction` type and its position is a `{x, y}` tuple.
  """
  defmodule Robot do
    defstruct direction: :north, position: {0, 0}
  end

  @doc """
  Create a Robot Simulator given an initial direction and position.
  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create() :: %Robot{}
  def create, do: %Robot{}

  @spec create(direction :: direction, position :: {integer, integer}) ::
          %Robot{} | {:error, String.t()}

  def create(direction, {x, y})
      when is_integer(x) and is_integer(y) and direction in @directions do
    %Robot{
      direction: direction,
      position: {x, y}
    }
  end

  def create(direction, _) when direction do
    {:error, "invalid direction"}
  end

  def create(_, _) do
    {:error, "invalid position"}
  end

  @doc """
  Makes the Robot turn left.
  """
  @spec turn_left(robot :: %Robot{}) :: %Robot{}
  def turn_left(robot) do
    {new_direction, _} =
      Enum.find(@direction_map, fn {_, direction} ->
        direction == robot.direction
      end)

    %{robot | direction: new_direction}
  end

  @spec turn_right(robot :: %Robot{}) :: %Robot{}
  defp turn_right(robot) do
    {_, new_direction} =
      Enum.find(@direction_map, fn {direction, _} ->
        direction == robot.direction
      end)

    %{robot | direction: new_direction}
  end

  @spec advance(robot :: %Robot{}) :: %Robot{}
  defp advance(robot) do
    {x, y} = robot.position

    new_position =
      case robot.direction do
        :north ->
          {x, y + 1}

        :east ->
          {x + 1, y}

        :south ->
          {x, y - 1}

        :west ->
          {x - 1, y}
      end

    %{robot | position: new_position}
  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: %Robot{}, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    if String.match?(instructions, ~r/(?![ARL])./) do
      {:error, "invalid instruction"}
    else
      Enum.reduce(String.graphemes(instructions), robot, fn instruction, robot ->
        case instruction do
          "L" -> turn_left(robot)
          "R" -> turn_right(robot)
          "A" -> advance(robot)
        end
      end)
    end
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: %Robot{}) :: direction
  def direction(robot) do
    robot.direction
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: %Robot{}) :: {integer, integer}
  def position(robot) do
    robot.position
  end
end
