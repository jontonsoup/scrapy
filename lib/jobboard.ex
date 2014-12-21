defmodule JB do
  use Application

  def start(_type, _args) do
    JB.Supervisor.start_link
    {:ok, self()}
  end
end
