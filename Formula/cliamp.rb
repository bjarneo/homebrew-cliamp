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
  version "1.37.3"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.37.3/cliamp-darwin-arm64"
      sha256 "6ee6126326f5c6d386e528cdf6a8d757fbc8762089dd99b7939b35867c292f56"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.37.3/cliamp-darwin-amd64"
      sha256 "cba8024b173ad1e4d02ff124e67034f2fe3c464c83df8c12c1225f3d8ca106cf"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.37.3/cliamp-linux-arm64"
      sha256 "da2f8f8945a0519ccf855893fc5f6e801bd2d98c8496b7ff0bc2de30d818d5a7"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.37.3/cliamp-linux-amd64"
      sha256 "e44d65f73dde0daeb7dd0ce0d038e225205e0554613beeed469c43e12e503e03"
    end
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
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cliamp --version")
  end
end
