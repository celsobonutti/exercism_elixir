defmodule RobotSimulator do
  @type direction ::
          :north
          | :east
          | :south
          | :west

  @type coordinates :: %{
          x: integer,
          y: integer
        }

  @type robot :: %{
          direction: direction,
          position: coordinates
        }

  @directions [:north, :east, :south, :west]

  @direction_map [
    {:north, :east},
    {:east, :south},
    {:south, :west},
    {:west, :north}
  ]

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: robot
  def create(direction \\ :north, coordinates \\ {0, 0})

  def create(direction, _) when direction not in @directions do
    {:error, "invalid direction"}
  end

  def create(direction, {x, y}) when is_integer(x) and is_integer(y) do
    %{
      direction: direction,
      position: %{x: x, y: y}
    }
  end

  def create(_, _) do
    {:error, "invalid position"}
  end

  @doc """
  Makes the Robot turn left.
  """
  @spec turn_left(robot :: robot) :: robot
  def turn_left(robot) do
    {new_direction, _} =
      Enum.find(@direction_map, fn {_, direction} ->
        direction == robot[:direction]
      end)

    %{robot | direction: new_direction}
  end

  @doc """
  Makes the Robot turn right.
  """
  @spec turn_right(robot :: robot) :: robot
  def turn_right(robot) do
    {_, new_direction} =
      Enum.find(@direction_map, fn {direction, _} ->
        direction == robot[:direction]
      end)

    %{robot | direction: new_direction}
  end

  @doc """
  Makes the Robot advance one position
  """
  @spec advance(robot :: robot) :: robot
  def advance(robot) do
    %{:x => x, :y => y} = robot[:position]

    new_position =
      case robot[:direction] do
        :north ->
          %{x: x, y: y + 1}

        :east ->
          %{x: x + 1, y: y}

        :south ->
          %{x: x, y: y - 1}

        :west ->
          %{x: x - 1, y: y}
      end

    %{robot | position: new_position}
  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: robot, instructions :: String.t()) :: any
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
  @spec direction(robot :: robot) :: atom
  def direction(robot) do
    robot[:direction]
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: robot) :: {integer, integer}
  def position(robot) do
    %{:x => x, :y => y} = robot[:position]
    {x, y}
  end
end
