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
  version "1.54.0"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.54.0/cliamp-darwin-arm64"
      sha256 "2e71d46e86e16c94718811e7ff64eb0054554f8c39126d65e20af0da0fe613d9"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.54.0/cliamp-darwin-amd64"
      sha256 "4e6143afdff16d2d01844105f72b31b25bc014dc6cdd2e88a2f4b0607f4c5dda"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.54.0/cliamp-linux-arm64"
      sha256 "479d03a55b11f5c04aba9847deaab40e418ced9e5e484ff4303e34291d293c76"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.54.0/cliamp-linux-amd64"
      sha256 "ea61c844ca8c509383dd97d5a1256ebc1e0ad2c8232f027578005db7cdee578f"
    end
  end

  resource "icon" do
    url "https://raw.githubusercontent.com/bjarneo/cliamp/v1.54.0/Cliamp.png"
    sha256 "8b68d5696b993879188c401843472ee53335ad6710be11944d0fe43bbd8e4787"
  end

  resource "desktop" do
    url "https://raw.githubusercontent.com/bjarneo/cliamp/v1.54.0/cliamp.desktop"
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
