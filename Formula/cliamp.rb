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
  version "1.18.0"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.18.0/cliamp-darwin-arm64"
      sha256 "c1dbe75d14b705202f373c79bc4821b09b8ecfe77c1a0de15661aa5f70c9dd51"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.18.0/cliamp-darwin-amd64"
      sha256 "a897cc4cf3dc7db7b58d5fa052e99885c0f279018da489b5eba59de79bdb7bc2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.18.0/cliamp-linux-arm64"
      sha256 "db13a1b1409ee7cf159d0044dc584e4f4dceebb7b73e3bede9156d6a93bbb79a"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.18.0/cliamp-linux-amd64"
      sha256 "3772496a4c1ed61522b63d2494bd31f80a90aa5e8805f4fbd2ea252ab69f16bd"
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
