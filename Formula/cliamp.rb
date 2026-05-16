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
  version "1.51.1"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.51.1/cliamp-darwin-arm64"
      sha256 "bc41fb7c1983339e3efbd076b445e496811dcaf85397677537b520b6dc9dec99"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.51.1/cliamp-darwin-amd64"
      sha256 "81f67423c2afe7a1a66e4b1baf4216feb3c5af1d766160185636f1ef65e1fb0e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.51.1/cliamp-linux-arm64"
      sha256 "ac50d002cd346b6a532c943dc202c258beca44033719420ea4c17dc20463d699"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.51.1/cliamp-linux-amd64"
      sha256 "806cd3066e1b62d0b94d283b63288fd574b06d4f6819b20feaef59565d0fb5a6"
    end
  end

  resource "icon" do
    url "https://raw.githubusercontent.com/bjarneo/cliamp/v1.51.1/Cliamp.png"
    sha256 "8b68d5696b993879188c401843472ee53335ad6710be11944d0fe43bbd8e4787"
  end

  resource "desktop" do
    url "https://raw.githubusercontent.com/bjarneo/cliamp/v1.51.1/cliamp.desktop"
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
