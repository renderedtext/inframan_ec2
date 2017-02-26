defmodule InframanEc2.Cli.List do
  alias InframanEc2.Instance
  alias TableRex.Table

  def execute(_) do
    instances = Instance.list

    instances
    |> Enum.sort_by(fn(instance) -> instance.name end)
    |> render_table
  end

  def render_table(instances) do
    header = [
      "#",
      "Instance ID",
      "Name",
      "Type",
      "State",
      "Availability Zone",
      "Public IP"
    ]

    data = instances |> Enum.with_index |> Enum.map(fn({instance, index}) ->
      [
        index,
        instance.id,
        instance.name,
        instance.type,
        instance.state,
        instance.zone,
        instance.public_ip,
      ]
    end)

    Table.new(data, header)
    |> Table.put_column_meta(0, align: :right)
    |> Table.render!
    |> IO.write
  end

end
