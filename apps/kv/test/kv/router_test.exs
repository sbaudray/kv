defmodule KV.RouterTest do
  use ExUnit.Case, async: true

  @tag :distributed
  test "route requests accros nodes" do
    assert KV.Router.route("hello", Kernel, :node, []) == :foo@sb
    assert KV.Router.route("world", Kernel, :node, []) == :bar@sb
  end

  test "raises on unknown entries" do
    assert_raise RuntimeError, ~r/could not find entry/, fn ->
      KV.Router.route(<<0>>, Kernel, :node, [])
    end
  end
end
