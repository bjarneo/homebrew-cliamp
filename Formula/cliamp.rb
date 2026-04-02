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
  version "1.32.3"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.32.3/cliamp-darwin-arm64"
      sha256 "f436cdae822b2676f9c525ea06881542f2879d81e88a245ff61effd3981b88fb"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.32.3/cliamp-darwin-amd64"
      sha256 "c9a40d310e5fa0315154ff1a74812bc37681b2d13c48fe7663f70ed8f2fcb52c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.32.3/cliamp-linux-arm64"
      sha256 "3b00d7bc2a4db95cdbdf38fb5904e3db5f82019f4ba1fb05dc0edf783fc550de"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.32.3/cliamp-linux-amd64"
      sha256 "39dfaf48dc32c4cee9e05b4d4e356c3dc3966a3ad2130e01a25685dba4e6acff"
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
