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
  version "2.0.0"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v2.0.0/cliamp-darwin-arm64"
      sha256 "4ce68a5910a1e554fa49dfca83974045618dd6d3f9bd3d325baab8ee55fdca29"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v2.0.0/cliamp-darwin-amd64"
      sha256 "703ae63d0d706da6dd3e8fee8bb12a70aeb53a994f5932e6baa0d0be7a4bcab0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v2.0.0/cliamp-linux-arm64"
      sha256 "0b80cd9410ed5b7732eaa0ac0313df92368aa25c9f4055c991f1125a0c2808d2"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v2.0.0/cliamp-linux-amd64"
      sha256 "b63817dac0405a0976fedbcdd8c635a6e05522c05b4da9e14f5b33b799c26ba2"
    end
  end

  resource "icon" do
    url "https://raw.githubusercontent.com/bjarneo/cliamp/v2.0.0/Cliamp.png"
    sha256 "4f405d464869d13f49bac8cfbd0839e447b111180ab37e8585337966d57c0011"
  end

  resource "desktop" do
    url "https://raw.githubusercontent.com/bjarneo/cliamp/v2.0.0/cliamp.desktop"
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
