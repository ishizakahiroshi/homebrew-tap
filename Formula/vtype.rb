# Homebrew formula for vtype desktop (child plan C9-C3). A template: the release workflow
# (.github/workflows/native-release.yml) replaces 0.1.0 and 9d7c8d4c519bbaa36b411661fadfd89cb0617433fc3a4c8f32deed151d84849e and attaches the
# result to the draft release as vtype.rb. Copy that file into the tap; see README.md here.
class Vtype < Formula
  desc "Voice input into any app, with Google Chrome's speech recognition"
  homepage "https://github.com/ishizakahiroshi/vtype"
  url "https://github.com/ishizakahiroshi/vtype/releases/download/native-v0.1.0/vtype-0.1.0-macos-universal.tar.gz"
  version "0.1.0"
  sha256 "9d7c8d4c519bbaa36b411661fadfd89cb0617433fc3a4c8f32deed151d84849e"
  license "MIT"

  depends_on :macos

  def install
    bin.install "vtype"
  end

  # `brew services start vtype` runs the daemon at login.
  service do
    run [opt_bin/"vtype", "daemon"]
    keep_alive false
  end

  def caveats
    <<~EOS
      Start vtype by running:
        vtype

      vtype needs Google Chrome: it starts Chrome in a profile of its own for
      the speech recognition. The first-run screen asks whether to start vtype
      at login (ticked by default); its settings page changes it later. From
      the command line, run once:
        vtype install
      (brew services start vtype also starts it at login, but vtype's settings
      page cannot see or switch that off; use one or the other.)

      Allow vtype in System Settings > Privacy & Security > Accessibility,
      so it can type into other apps. After an update, you may need to allow it again.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/vtype --version")
  end
end
