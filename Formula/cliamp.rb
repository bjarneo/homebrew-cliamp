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
  version "2.2.0"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v2.2.0/cliamp-darwin-arm64"
      sha256 "52210e7a8aeac519154b9c556851684a3be63e54d88ae78c61c9f5ec690849f3"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v2.2.0/cliamp-darwin-amd64"
      sha256 "67662a8ea57aaf22030c4d096805a26700787c017085e8ec4844e7b77e8da75c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v2.2.0/cliamp-linux-arm64"
      sha256 "94ae39f5ade4b762293c479c120242925b70187cb09101c9c9ea911f4811a8b4"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v2.2.0/cliamp-linux-amd64"
      sha256 "60fd335e367d920fbfa898a6c87e419616acb55e712e17b5439ab7573f60d882"
    end
  end

  resource "icon" do
    url "https://raw.githubusercontent.com/bjarneo/cliamp/v2.2.0/Cliamp.png"
    sha256 "4f405d464869d13f49bac8cfbd0839e447b111180ab37e8585337966d57c0011"
  end

  resource "desktop" do
    url "https://raw.githubusercontent.com/bjarneo/cliamp/v2.2.0/cliamp.desktop"
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
