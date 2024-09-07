defmodule ExDbSeeds do
  @moduledoc false

  use Application

  def start(_type, _args) do
    ExDbSeeds.Sequence.start_link()
  end
end
