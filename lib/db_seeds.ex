defmodule DbSeeds do
  @moduledoc false

  use Application

  def start(_type, _args) do
    DbSeeds.Sequence.start_link()
  end
end
