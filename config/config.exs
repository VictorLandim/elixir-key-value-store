import Config
{:ok, host} = :inet.gethostname()
config :iex, default_prompt: "no-name@#{host} $"

config :kv, :routing_table, [{?a..?z, node()}]

if Mix.env() == :prod do
  config :kv, :routing_table, [
    {?a..?m, :"foo@#{host}"},
    {?n..?z, :"bar@#{host}"}
  ]
end
