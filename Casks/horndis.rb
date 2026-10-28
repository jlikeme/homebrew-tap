cask "horndis" do
  version "0.3.12"
  sha256 "b33d61ebe7be7e821d6e9ced7701504fd15617867f7dd7cd7fcaa0a2613847a3"

  url "https://github.com/jlikeme/HoRNDIS-Userspace/releases/download/v0.3.12/HoRNDIS-Userspace-v0.3.12-macos-universal.pkg"
  name "HoRNDIS Userspace"
  desc "Android RNDIS USB tethering without a kernel extension"
  homepage "https://github.com/jlikeme/HoRNDIS-Userspace"

  depends_on macos: :big_sur

  pkg "HoRNDIS-Userspace-v0.3.12-macos-universal.pkg"

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
    New services use DHCP and appear last. Startup restores the saved identity
    and relative position; full uninstall also clears the recovery record.

    It also installs the `horndis` command and `man horndis`. The package
    requests administrator authorization to activate its fixed network service.
    If the menu bar app is quit, reopen it from Applications or run:
      horndis start
  EOS
end
