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
  version "1.22.0"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.22.0/cliamp-darwin-arm64"
      sha256 "f8ecf8aadbea01224e6e911fdfccc9575fba9687a96a695e4ab29c3f04439b01"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.22.0/cliamp-darwin-amd64"
      sha256 "cd586c2049df02ea4d7e5f1a8dbe67aaa7715f1561712f625787cfd3db33acfd"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.22.0/cliamp-linux-arm64"
      sha256 "215eeee9853387bb9dd0976a2448e01fb709d50f6effc21eafc36209baeca12d"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.22.0/cliamp-linux-amd64"
      sha256 "da74454f140945943ee00ee1c9bc3d9e5252f5d5cd88c6b8073c25ef320f331d"
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
