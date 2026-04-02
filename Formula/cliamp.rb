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
  version "1.32.4"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.32.4/cliamp-darwin-arm64"
      sha256 "4ba04498178bb7db8abd7521a7c8a2baf48fc5ea079e5ba0f5d2edf7bfe2ab08"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.32.4/cliamp-darwin-amd64"
      sha256 "9f89b31afb38c558b6ba0072d1c9d3f0cd0e938e7b7e1bfde00c86d83b92a1c2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.32.4/cliamp-linux-arm64"
      sha256 "5df94732b79639f65421f8a9e5d97c23c1f57aaf5e7a23d04853bf1b916efccb"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.32.4/cliamp-linux-amd64"
      sha256 "6af0cd1986a3270ed77948bb8fdea99f17d0775dd4558309622acbb0f96b1a79"
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
