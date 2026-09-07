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
  version "2.1.0"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v2.1.0/cliamp-darwin-arm64"
      sha256 "8a5f57073f6e2570a63761b2132e2c6835b101be0d4d664d059248fd0ca89e7c"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v2.1.0/cliamp-darwin-amd64"
      sha256 "7404a210ef61cbacb13fc1fa10252871d3dcee89d17c20e43dd57295b37501b8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v2.1.0/cliamp-linux-arm64"
      sha256 "8cc054cd706fe86e3e0209f3dd265f90146b49c1297f7f146730de703db710a1"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v2.1.0/cliamp-linux-amd64"
      sha256 "44a6f4808e1fa97b04c9a594ffefd0b8dd7818c36023bfbc58762d37278e77c2"
    end
  end

  resource "icon" do
    url "https://raw.githubusercontent.com/bjarneo/cliamp/v2.1.0/Cliamp.png"
    sha256 "4f405d464869d13f49bac8cfbd0839e447b111180ab37e8585337966d57c0011"
  end

  resource "desktop" do
    url "https://raw.githubusercontent.com/bjarneo/cliamp/v2.1.0/cliamp.desktop"
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
