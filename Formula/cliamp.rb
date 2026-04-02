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
  version "1.32.0"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.32.0/cliamp-darwin-arm64"
      sha256 "c298798027e7a7b816b9aaf8d6e68112d45b26842f3711303200419cfde7d22d"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.32.0/cliamp-darwin-amd64"
      sha256 "acb24150fbe4a94dc475521cc202c0794a69ed9a20ac12e3e5336fa1d333d080"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.32.0/cliamp-linux-arm64"
      sha256 "6718d126eb7ef2926bdb3dd224bceb024e2d32d8d1eb5267159f25e949789d4f"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.32.0/cliamp-linux-amd64"
      sha256 "4cd33358124dd03eab19832e7ad65abdcc046987d7a8b93bdcd5d05d282ee883"
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
