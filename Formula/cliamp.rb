class Cliamp < Formula
  desc "A retro terminal music player inspired by Winamp 2.x"
  homepage "https://github.com/bjarneo/cliamp"

  head "https://github.com/bjarneo/cliamp.git", branch: "main"

  depends_on "flac"
  depends_on "libvorbis"
  depends_on "libogg"
  depends_on "ffmpeg" => :recommended
  depends_on "yt-dlp" => :recommended
  depends_on "go" => :build
  version "1.47.0"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.47.0/cliamp-darwin-arm64"
      sha256 "2498296198c30ee9dcbbac8570a6d74d0aa0233b59f0d9613768e5c03b5f1ff3"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.47.0/cliamp-darwin-amd64"
      sha256 "d415d6e0d4175cc6ab17409c8325e39ed579a77eb9072ad78e3bffa70437f939"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.47.0/cliamp-linux-arm64"
      sha256 "4547e2f45df8f3cdbce4a9ff12de64f0ccd288004a59ddca9efcc5d79a736f50"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.47.0/cliamp-linux-amd64"
      sha256 "2caa4c98a72e0e0a2fa102bf00e49538306ca58d030625c3949f93e76b5e24f0"
    end
  end

  resource "icon" do
    url "https://raw.githubusercontent.com/bjarneo/cliamp/v1.47.0/Cliamp.png"
    sha256 "8b68d5696b993879188c401843472ee53335ad6710be11944d0fe43bbd8e4787"
  end

  resource "desktop" do
    url "https://raw.githubusercontent.com/bjarneo/cliamp/v1.47.0/cliamp.desktop"
    sha256 "3e2af63bbd6ddfbee31f2312a82d39d56bb332d209f2593450a4c93194386ebe"
  end

  def install
    if build.head?
      # Build from source for HEAD
      system "go", "build", "-ldflags", "-s -w", "-o", bin/"cliamp", "."
    else
      # Use pre-built binary for stable releases
      binary = Dir["cliamp-*"].first
      bin.install binary => "cliamp"
    end

    # Ship icon under pkgshare so it's always available; expose as
    # XDG icon + desktop entry on Linux for app-launcher integration.
    resource("icon").stage { pkgshare.install "Cliamp.png" => "cliamp.png" }

    on_linux do
      (share/"icons/hicolor/512x512/apps").install_symlink pkgshare/"cliamp.png"
      (share/"pixmaps").install_symlink pkgshare/"cliamp.png"
      resource("desktop").stage { (share/"applications").install "cliamp.desktop" }
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cliamp --version")
  end
end
