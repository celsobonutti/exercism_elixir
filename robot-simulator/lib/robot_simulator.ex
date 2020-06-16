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
  def create(direction \\ :north, {x, y} \\ {0, 0}) do
    %{
      direction: direction,
      position: %{x: x, y: y}
    }
  end

  @doc """
  Makes the Robot turn left.
  """
  @spec turn_left(robot :: robot) :: robot
  def turn_left(robot) do
    new_direction = Enum.find(@direction_map, fn direction -> elem(direction, 0) ==  end)

    %{robot | direction: new_direction}
  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: robot, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: robot) :: atom
  def direction(robot) do
    robot.direction
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: robot) :: {integer, integer}
  def position(robot) do
    {robot.position.x, robot.position.y}
  end
end
