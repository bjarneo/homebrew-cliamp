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
  version "1.33.8"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.33.8/cliamp-darwin-arm64"
      sha256 "d706233957b19dac969c8518b7d9fc67b665f29daacf8dba51ec3fece0d2db8d"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.33.8/cliamp-darwin-amd64"
      sha256 "6c7f78c3933403ad1fa8ed8f05f57d650d9bf77dc98c55af6ba2ba947d92480d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.33.8/cliamp-linux-arm64"
      sha256 "7d7068a7c8c1a061c7fe0d64a06e961345dd1d094cdd1dfe6e0a43dfa76ab891"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.33.8/cliamp-linux-amd64"
      sha256 "5accd9d62adbed8414cc69edd1b34ba97a937a6c44caf4dcf0e0fbfa3932ebf7"
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
