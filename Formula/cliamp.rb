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
  version "1.32.1"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.32.1/cliamp-darwin-arm64"
      sha256 "192a10f779cef7ae2c289de7650ec6821e987dec7b9197b5dd82c5c3ad29db75"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.32.1/cliamp-darwin-amd64"
      sha256 "d2b908112f582b5bf9d134b24f036fba826446b2eb18b4e565fbdbb169848f22"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.32.1/cliamp-linux-arm64"
      sha256 "2660bf050be641c34bb9b25f860911e8363b0ca5829aee4f64592457fb6764c8"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.32.1/cliamp-linux-amd64"
      sha256 "a935d88b214d13aeb4fa85df9ceb531628a92cdda38d951ce96106234e93aaca"
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
