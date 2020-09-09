defmodule KV.RouterTest do
  # How to run:
  # We need two nodes running
  # On folder [...]/apps/kv, open two terminals
  # 1. $ iex --sname bar -S mix
  # 2s. $ elixir --sname foo -S mix test

  use ExUnit.Case

  setup_all do
    current = Application.get_env(:kv, :routing_table)

    {:ok, host} = :inet.gethostname()

    Application.put_env(:kv, :routing_table, [
      {?a..?m, :"foo@#{host}"},
      {?n..?z, :"bar@#{host}"}
    ])

    on_exit(fn -> Application.put_env(:kv, :routing_table, current) end)
  end

  @tag :distributed
  test "route requests across nodes" do
    {:ok, host} = :inet.gethostname()

    assert KV.Router.route("hello", Kernel, :node, []) == :"foo@#{host}"
    assert KV.Router.route("world", Kernel, :node, []) == :"bar@#{host}"
  end

  test "raises on unknown entries" do
    assert_raise RuntimeError, ~r/Could not find entry/, fn ->
      KV.Router.route(<<0>>, Kernel, :node, [])
    end
  end
end
