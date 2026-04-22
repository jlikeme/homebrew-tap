class Imsg < Formula
  desc "Send, read, and stream iMessage and SMS from the terminal"
  homepage "https://github.com/jlikeme/imsg"
  url "https://github.com/jlikeme/imsg.git",
      tag:      "v0.5.0-1",
      revision: "9754cdf632c679cc5df159dce6e90112bbd47692"
  license "MIT"
  head "https://github.com/jlikeme/imsg.git", branch: "main"

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
      imsg reads ~/Library/Messages/chat.db and drives Messages.app via AppleScript.
      Grant your terminal both permissions before running:
        • System Settings → Privacy & Security → Full Disk Access
        • System Settings → Privacy & Security → Automation → Messages

      For SMS relay, enable "Text Message Forwarding" on your iPhone to this Mac.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/imsg --version")
  end
end
