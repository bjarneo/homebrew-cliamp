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
  version "2.4.0"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v2.4.0/cliamp-darwin-arm64"
      sha256 "f12a36efe27d8eaaf1ab489be2270850bea4a0f63f694cc1688693bf13e256b4"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v2.4.0/cliamp-darwin-amd64"
      sha256 "836d0ed3d46a39ea0ff75b17738e77c2652c03fbc46aefb78110cb6664a41ee6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v2.4.0/cliamp-linux-arm64"
      sha256 "4e686e9b5188030bd3382c7fac997077bbdff8953fbab0003c49874b5f9ea1fc"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v2.4.0/cliamp-linux-amd64"
      sha256 "2ee17d8f613d9dd23d124b8f5580111610f5aa396b20f2818e388f7b7a227152"
    end
  end

  resource "icon" do
    url "https://raw.githubusercontent.com/bjarneo/cliamp/v2.4.0/Cliamp.png"
    sha256 "4f405d464869d13f49bac8cfbd0839e447b111180ab37e8585337966d57c0011"
  end

  resource "desktop" do
    url "https://raw.githubusercontent.com/bjarneo/cliamp/v2.4.0/cliamp.desktop"
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
