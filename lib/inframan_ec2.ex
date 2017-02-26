defmodule InframanEc2 do

  def main(["list" | params]) do
    InframanEc2.Cli.List.execute(params)
  end

  def main(["ssh" | params]) do
    InframanEc2.Cli.Ssh.execute(params)
  end

  def main(args) do
    IO.puts "Unrecognized command"
    System.halt(1)
  end

end
