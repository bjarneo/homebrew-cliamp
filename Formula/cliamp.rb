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
  version "1.28.2"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.28.2/cliamp-darwin-arm64"
      sha256 "dcc0462f13fa70645ac2e27529d10ebef32b706202d66b9af8e48d0b17066ca8"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.28.2/cliamp-darwin-amd64"
      sha256 "6440a48c4dd9b8f1235d2e182b9bc2f66875f73ceedee368f7795c4b7352a594"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.28.2/cliamp-linux-arm64"
      sha256 "074a118c156d1fa2e2365d693e0ccda5f353b3f87865f6311d3295d87cb802b7"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.28.2/cliamp-linux-amd64"
      sha256 "c38c0a8f71d21890f0c271d49927de0081ede7850fb2b1f16d1f34c176155dae"
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
