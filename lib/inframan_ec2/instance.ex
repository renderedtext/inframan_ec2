defmodule InframanEc2.Instance do
  defstruct name: nil,
            id: nil,
            type: nil,
            state: nil,
            zone: nil,
            public_ip: nil

  def list do
    response     = execute!("aws ec2 describe-instances") |> Poison.decode!
    reservations = response["Reservations"]
    instances    = reservations |> Enum.flat_map(fn(r) -> r["Instances"] end)

    instances |> Enum.map(fn(instance) ->
      %InframanEc2.Instance{
        name: Enum.find(instance["Tags"] || [], fn(tag) -> tag["Key"] == "Name" end)["Value"] || "[NO NAME]",
        id: instance["InstanceId"],
        type: instance["InstanceType"],
        state: instance["State"]["Name"],
        zone: instance["Placement"]["AvailabilityZone"],
        public_ip: instance["PublicIpAddress"]
      }
    end)
  end

  defp execute!(command) do
    {result, exit_status} = System.cmd("sh", ["-c", command])

    if exit_status == 0 do
      result
    else
      raise "Command instances"
    end
  end

end
