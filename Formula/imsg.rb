class Imsg < Formula
  desc "Send and read iMessage / SMS from the terminal"
  homepage "https://github.com/jlikeme/imsg"
  url "https://github.com/jlikeme/imsg.git",
      tag: "v0.5.0-1"
  license "MIT"

  # macOS Sonoma (14.0) or later required
  depends_on xcode: ["15.0", :build]
  depends_on macos: :sonoma

  def install
    system "bash", "scripts/generate-version.sh"
    system "swift", "package", "resolve"
    system "bash", "scripts/patch-deps.sh"
    system "swift", "build",
           "-c", "release",
           "--product", "imsg",
           "--disable-sandbox"

    binary = Dir[".build/**/release/imsg"].find { |p| File.file?(p) && File.executable?(p) }
    odie "built imsg binary not found" unless binary

    system "codesign", "--force", "--sign", "-",
           "--entitlements", "Resources/imsg.entitlements",
           "--identifier", "com.steipete.imsg",
           binary

    libexec.install binary => "imsg"
    Dir[File.join(File.dirname(binary), "*.bundle")].each do |bundle|
      libexec.install bundle
    end
    bin.write_exec_script libexec/"imsg"
  end

  def caveats
    <<~EOS
      imsg needs Full Disk Access to read the Messages database.

      To grant permission:
      1. Open System Settings > Privacy & Security > Full Disk Access
      2. Enable access for your Terminal application

      To send messages, allow Terminal to control Messages.app:
      System Settings > Privacy & Security > Automation
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/imsg --version")
    assert_match "Send and read iMessage", shell_output("#{bin}/imsg --help")
  end
end
