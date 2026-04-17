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
  version "1.37.0"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.37.0/cliamp-darwin-arm64"
      sha256 "a1dd6bde3d334cf03b2a244e4d23d437a28e671fcce58e9578928193e8221da7"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.37.0/cliamp-darwin-amd64"
      sha256 "d7ff04bf8905157fa18d78adc17bf89e76393eed1a2d5de52da91fbd7418df8f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.37.0/cliamp-linux-arm64"
      sha256 "d643762c66d4035ff909c68080bfae285a1c944960a1957388054ee7cb4a0e21"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.37.0/cliamp-linux-amd64"
      sha256 "678ca5bb3bdfd151e755f3ce52a4c8198eaaf4c8ed7a244b4022c755988396fe"
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
