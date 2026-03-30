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
  version "1.31.5"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.31.5/cliamp-darwin-arm64"
      sha256 "f1769f7d305dbfefc408d43701f9219752061e5ee8eec753220a4db7ea153b8f"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.31.5/cliamp-darwin-amd64"
      sha256 "15e8f2e128078d2ea6f6b022b5fc0822d04c34e6be101e388afa765f7b7e4b92"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.31.5/cliamp-linux-arm64"
      sha256 "9e1602e5c456ff5cd798fcfbbcbca8c98071ef270f21bfd5a3312efa545b209f"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.31.5/cliamp-linux-amd64"
      sha256 "cc943e8b200b853c9cd9ae507ce7038583d399a0917b4ebb3b7944e13e470dca"
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
