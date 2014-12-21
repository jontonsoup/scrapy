defmodule JB.Supervisor do
  import Task.Supervisor

  def start_link do
    {:ok, pid} = Task.Supervisor.start_link()
    Task.Supervisor.async(pid, JB.Populator, :start_scrape, [])
  end
end
