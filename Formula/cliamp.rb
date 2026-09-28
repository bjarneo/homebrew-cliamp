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
  version "2.3.0"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v2.3.0/cliamp-darwin-arm64"
      sha256 "5917a5071c79768c6c8eb33d027a3f4bd0713a27ae9531ca1a161bb6c13dd357"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v2.3.0/cliamp-darwin-amd64"
      sha256 "c0b5af09abca83a615d2f47146adcfc61b0723b333509b5eeb6c8ada11cce6d3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v2.3.0/cliamp-linux-arm64"
      sha256 "827b4aa879feecab33ea621dc1460c60ffa765c210b5046d679ce5a4073d2b32"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v2.3.0/cliamp-linux-amd64"
      sha256 "5c59b5380c5165b473c06148c108ee60a18a1f9961f8013e38b4a68ed5def641"
    end
  end

  resource "icon" do
    url "https://raw.githubusercontent.com/bjarneo/cliamp/v2.3.0/Cliamp.png"
    sha256 "4f405d464869d13f49bac8cfbd0839e447b111180ab37e8585337966d57c0011"
  end

  resource "desktop" do
    url "https://raw.githubusercontent.com/bjarneo/cliamp/v2.3.0/cliamp.desktop"
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
