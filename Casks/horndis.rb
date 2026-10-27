cask "horndis" do
  version "0.3.11"
  sha256 "286f3c7b6e300587018f2f66d0fe7afd2c0826f539f36a5b1faf5cd08372b2a6"

  url "https://github.com/jlikeme/HoRNDIS-Userspace/releases/download/v0.3.11/HoRNDIS-Userspace-v0.3.11-macos-universal.pkg"
  name "HoRNDIS Userspace"
  desc "Android RNDIS USB tethering without a kernel extension"
  homepage "https://github.com/jlikeme/HoRNDIS-Userspace"

  depends_on macos: :big_sur

  pkg "HoRNDIS-Userspace-v0.3.11-macos-universal.pkg"

  # Resolve the operation when the bundled script actually runs. A constant
  # argument is safe to retain in Homebrew's installed JSON metadata.
  uninstall script:  {
              executable: "/Applications/HoRNDIS Status.app/Contents/Resources/horndis-uninstall",
              args:       ["--homebrew"],
              sudo:       true,
            },
            pkgutil: "io.github.noahhhi.horndis.pkg"

  caveats <<~EOS
    HoRNDIS installs its menu bar app in:
      /Applications/HoRNDIS Status.app

    Upgrades and reinstalls preserve the HoRNDIS USB network service, its
    identifier, network settings and service order. A full uninstall removes it.

    It also installs the `horndis` command and `man horndis`. The package
    requests administrator authorization to activate its fixed network service.
    If the menu bar app is quit, reopen it from Applications or run:
      horndis start
  EOS
end
