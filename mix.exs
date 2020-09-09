defmodule KvUmbrella.MixProject do
  use Mix.Project

  def project do
    [
      apps_path: "apps",
      version: "0.1.0",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      releases: [
        foo: [
          version: "0.0.1",
          applications: [kv_server: :permanent, kv: :permanent],
          cookie: "weknoweachother"
        ],
        bar: [
          version: "0.0.1",
          applications: [kv: :permanent],
          cookie: "weknoweachother"
        ]
      ]
    ]
  end

  defp deps do
    []
  end
end
