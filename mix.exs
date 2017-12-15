defmodule NervesSystemX8664.Mixfile do
  use Mix.Project

  @app :nerves_system_x86_64
  @version Path.join(__DIR__, "VERSION")
           |> File.read!()
           |> String.trim()

  def project do
    [
      app: @app,
      version: @version,
      elixir: "~> 1.4",
      compilers: Mix.compilers() ++ [:nerves_package],
      nerves_package: nerves_package(),
      description: description(),
      package: package(),
      deps: deps(),
      aliases: ["deps.precompile": ["nerves.env", "deps.precompile"]]
    ]
  end

  def application do
    []
  end
  
  def nerves_package do
    [
      type:  :system,
      artifact_url: [
        "https://github.com/nerves-project/#{@app}/releases/download/v#{@version}/#{@app}-v#{@version}.tar.gz"
      ],
      platform: Nerves.System.BR,
      platform_config: [
        defconfig: "nerves_defconfig"
      ],
      checksum: package_files()
    ]
  end

  defp deps do
    [
      {:nerves, "~> 0.8", runtime: false},
      {:nerves_system_br, "0.16.1-2017-11", runtime: false},
      {:nerves_toolchain_x86_64_unknown_linux_musl, "~> 0.12.1", runtime: false},
      {:nerves_system_linter, "~> 0.2.2", runtime: false}
    ]
  end

  defp description do
    """
    Nerves System - x86_64
    """
  end

  defp package do
    [
      maintainers: ["Frank Hunleth"],
      files: package_files(),
      licenses: ["Apache 2.0"],
      links: %{"Github" => "https://github.com/nerves-project/#{@app}"}
    ]
  end

  defp package_files do
    [
      "LICENSE",
      "mix.exs",
      "nerves_defconfig",
      "README.md",
      "VERSION",
      "rootfs_overlay",
      "fwup.conf",
      "linux-4.13.defconfig",
      "grub.cfg",
      "post-createfs.sh"
    ]
  end
end
