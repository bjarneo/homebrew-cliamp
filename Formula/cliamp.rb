class Cliamp < Formula
  desc "A retro terminal music player inspired by Winamp 2.x"
  homepage "https://github.com/bjarneo/cliamp"

  head do
    url "https://github.com/bjarneo/cliamp.git", branch: "main"
    depends_on "go" => :build
  end

  depends_on "flac"
  depends_on "libvorbis"
  depends_on "libogg"
  depends_on "mpg123"
  depends_on "ffmpeg" => :recommended
  depends_on "yt-dlp" => :recommended
  version "2.0.1"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v2.0.1/cliamp-darwin-arm64"
      sha256 "8044ec0d0bc6a14ec29bc36ec3ff8f9bc697aae67d88df845c9fd7caba61ecba"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v2.0.1/cliamp-darwin-amd64"
      sha256 "e94e43863e85332add8569300e1ad04b67ecd9a8e832024bcc00b0c22a9c6af1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v2.0.1/cliamp-linux-arm64"
      sha256 "8eb00f3965712d87a55dea029957d40ceb4c7767fdc14db5ba973508204d5936"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v2.0.1/cliamp-linux-amd64"
      sha256 "a96c2c683bc5c58eeee496e3cc89113da46051a74fe7b2214c7f4092758b852c"
    end
  end

  resource "icon" do
    url "https://raw.githubusercontent.com/bjarneo/cliamp/v2.0.1/Cliamp.png"
    sha256 "4f405d464869d13f49bac8cfbd0839e447b111180ab37e8585337966d57c0011"
  end

  resource "desktop" do
    url "https://raw.githubusercontent.com/bjarneo/cliamp/v2.0.1/cliamp.desktop"
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
