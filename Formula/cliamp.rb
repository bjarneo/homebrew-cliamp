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
  version "1.21.0"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.21.0/cliamp-darwin-arm64"
      sha256 "8f6bf22aa0b56f27eb7fb322cc5ed42667a2d4783c56a930f97920a907015753"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.21.0/cliamp-darwin-amd64"
      sha256 "b1a1b23af12db720d831b3145750a61bde64685ac6ef3d2b4b1ce42464714b63"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.21.0/cliamp-linux-arm64"
      sha256 "a307a9ad516525a6cad7e32930610d9f6e78e44fb74d17b2d6a9e0cf46a0792e"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.21.0/cliamp-linux-amd64"
      sha256 "ac8067c26bd0d6dd12cc5e8606880fabe3074358880123762f1aba88be3b958c"
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
