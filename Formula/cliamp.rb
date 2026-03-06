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
  version "1.18.1"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.18.1/cliamp-darwin-arm64"
      sha256 "7bb947eaaac86c111c8587b09a94535a63485d4a3895c71121e9ef257701bb3b"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.18.1/cliamp-darwin-amd64"
      sha256 "61847c7a15b92b98bd8357c27736ec0657e701b83aa14b358ca6daf461a2b919"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.18.1/cliamp-linux-arm64"
      sha256 "4ccdaa3d92496e319f253ef14aeba01f5ae69adbd66b5e82b9a079c7256b5159"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.18.1/cliamp-linux-amd64"
      sha256 "42604ba08f21e9ae4b63c277f87b5792f64248099f512087f0aac04661fa073f"
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
