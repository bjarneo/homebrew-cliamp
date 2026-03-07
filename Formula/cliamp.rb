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
  version "1.20.0"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.20.0/cliamp-darwin-arm64"
      sha256 "c6cac11ce9dead0d7505773e6387d045d74ab7fbfbe1f5514d08912f0548d8cf"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.20.0/cliamp-darwin-amd64"
      sha256 "120ddf0fc7158f314af47c0830444da4574a3b4dc1881ceb022c4f38f0b39b0b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.20.0/cliamp-linux-arm64"
      sha256 "0106474d624aa63586afe878a8f09a3d06a76486319a2f31aedfc4a2ff056cba"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.20.0/cliamp-linux-amd64"
      sha256 "5d34c66251a838de0079abf8a8364e5766c932d586313a21d38938345a1cfa28"
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
