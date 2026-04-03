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
  version "1.33.1"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.33.1/cliamp-darwin-arm64"
      sha256 "49047796753ee66909ff9f8628e05ebc230d6dfa9c490020613a1f37a5b28f92"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.33.1/cliamp-darwin-amd64"
      sha256 "49afd55991c775e61d9cc1fcecce63f71d6d4ed37243757b034a72cb637388f6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.33.1/cliamp-linux-arm64"
      sha256 "d27bd9623f786c1a9872e1c34575179dfa4d8c9b2a9030395f244034e18069b7"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.33.1/cliamp-linux-amd64"
      sha256 "15bb646c61b1960df7e4f311c59d9ed496ec51fe6460956d0991f845c5f303e8"
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
