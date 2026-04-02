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
  version "1.32.2"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.32.2/cliamp-darwin-arm64"
      sha256 "5e387e2f3a5b1f4d0742c5e2462700f83dcd7e5dead72f2d3170785296fd1170"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.32.2/cliamp-darwin-amd64"
      sha256 "950fd60cc6f4a7d2d3c081735d6db3cab2a47e2555ff0cf68120dab9d431f17f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.32.2/cliamp-linux-arm64"
      sha256 "aa039e100b5dbf237bd44b5cb75342a2f04655ad502879367382cc6ff3927c23"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.32.2/cliamp-linux-amd64"
      sha256 "a2cb9a4806987f944660fa9af3d5f0a333b91318425c0ece151c1b0ff2948039"
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
